import 'package:x_dependency_injector/model/dependency_type_config.dart';

class InjectTypeConfig {
  InjectTypeConfig(this.injectType, {required this.importPath, this.dependencies});

  final String injectType;
  final String importPath;
  final List<DependencyTypeConfig>? dependencies;

  InjectTypeConfig.fromJson(Map<String, dynamic> json)
      : injectType = json['injectType'],
        importPath = json['importPath'],
        dependencies = (json['dependencies'] as List<dynamic>?)
            ?.map((e) => DependencyTypeConfig.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
        'injectType': injectType,
        'importPath': importPath,
        'dependencies': dependencies?.map((e) => e.toJson()).toList(),
      };
}
