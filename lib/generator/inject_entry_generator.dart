import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

import '../model/inject_type_config.dart';
import '../inject_annotation.dart';

class InjectEntryGenerator extends GeneratorForAnnotation<InjectEntry> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final injectableConfigFiles = Glob("lib/**.inject.json");
    final jsonData = <Map<String, dynamic>>[];
    await for (final id in buildStep.findAssets(injectableConfigFiles)) {
      final json = jsonDecode(await buildStep.readAsString(id));
      jsonData.addAll([...json]);
    }

    final deps = <InjectTypeConfig>[];
    for (final json in jsonData) {
      deps.add(InjectTypeConfig.fromJson(json));
    }

    if (element is FunctionElement) {
      return _generateEntry(deps);
    } else {
      return null;
    }
  }

  _generateEntry(List<InjectTypeConfig> deps) {
    final buffer = StringBuffer();
    final imports = <String>{};

    for (final dep in deps) {
      imports.add(dep.importPath);
      for (final dependency in dep.dependencies ?? []) {
        imports.add(dependency.importPath);
      }
    }

    // 写入导入语句
    buffer.writeln("import 'package:get/get.dart';");
    for (final import in imports) {
      buffer.writeln("import '$import';");
    }
    buffer.writeln();

    buffer.writeln('extension GetXInjectableX on GetInterface');
    buffer.writeln('{');
    buffer.writeln('void injectDependencies() {');

    for (final dep in deps) {
      if (dep.dependencies == null || dep.dependencies!.isEmpty) {
        buffer.writeln("  Get.lazyPut<${dep.injectType}>(() => ${dep.injectType}(), fenix: true);");
      } else {
        buffer.write("  Get.lazyPut<${dep.injectType}>(() => ${dep.injectType}(");
        buffer.write(
            dep.dependencies!.map((d) => "Get.find<${d.type}>()").join(', '));
        buffer.writeln("), fenix: true);");
      }
    }

    buffer.writeln('}');
    buffer.writeln('}');
    return buffer.toString();
  }
}
