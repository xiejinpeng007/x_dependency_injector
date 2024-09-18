class DependencyTypeConfig {
  final String type;
  final String importPath;

  DependencyTypeConfig({
    required this.type,
    required this.importPath,
  });

  Map<String, dynamic> toJson() => {
        'type': type,
        'importPath': importPath,
      };

  factory DependencyTypeConfig.fromJson(Map<String, dynamic> json) {
    return DependencyTypeConfig(
      type: json['type'] as String,
      importPath: json['importPath'] as String,
    );
  }
}
