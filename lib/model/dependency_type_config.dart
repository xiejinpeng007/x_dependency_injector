class DependencyTypeConfig {
  final String type;
  final String importPath;

  DependencyTypeConfig({
    required this.type,
    required this.importPath,
  });

  // 添加 toJson 方法
  Map<String, dynamic> toJson() => {
        'type': type,
        'importPath': importPath,
      };

  // 添加 fromJson 工厂构造函数
  factory DependencyTypeConfig.fromJson(Map<String, dynamic> json) {
    return DependencyTypeConfig(
      type: json['type'] as String,
      importPath: json['importPath'] as String,
    );
  }
}
