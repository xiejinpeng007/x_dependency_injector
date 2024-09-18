import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:x_dependency_injector/model/inject_type_config.dart';
import 'package:x_dependency_injector/model/dependency_type_config.dart';
import 'package:x_dependency_injector/inject_annotation.dart';
import 'package:source_gen/source_gen.dart';

class InjectUseCaseGenerator extends Generator {
  TypeChecker get typeChecker => const TypeChecker.fromRuntime(InjectUseCase);

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final configs = library.classes
        .where((c) => typeChecker.hasAnnotationOf(c))
        .map((c) => _createInjectTypeConfig(c, buildStep))
        .toList();

    return configs.isEmpty ? '' : jsonEncode(configs);
  }

  InjectTypeConfig _createInjectTypeConfig(
      ClassElement element, BuildStep buildStep) {
    final constructor = element.constructors
            .where((c) => c.parameters.isNotEmpty)
            .firstOrNull ??
        element.constructors.firstOrNull;

    final dependencies = constructor?.parameters
        .map((param) => _createDependencyTypeConfig(param.type, buildStep))
        .toList();

    return InjectTypeConfig(
      element.displayName,
      importPath: element.source.uri.toString(),
      dependencies: dependencies,
    );
  }

  DependencyTypeConfig _createDependencyTypeConfig(
      DartType type, BuildStep buildStep) {
    final element = type.element;
    final importPath = element?.source?.uri.toString() ?? '';
    return DependencyTypeConfig(
      type: type.element?.displayName ?? '',
      importPath: importPath,
    );
  }
}
