import 'package:x_dependency_injector/model/dependency_type_config.dart';

class InjectTypeConfig {
  InjectTypeConfig(this.injectType, {required this.importPath, this.dependencies});

  final String injectType;
  final String importPath;
  final List<DependencyTypeConfig>? dependencies;

  // 添加 fromJson 构造函数
  InjectTypeConfig.fromJson(Map<String, dynamic> json)
      : injectType = json['injectType'],
        importPath = json['importPath'],
        dependencies = (json['dependencies'] as List<dynamic>?)
            ?.map((e) => DependencyTypeConfig.fromJson(e))
            .toList();

  // 添加 toJson 方法
  Map<String, dynamic> toJson() => {
        'injectType': injectType,
        'importPath': importPath,
        'dependencies': dependencies?.map((e) => e.toJson()).toList(),
      };
}
