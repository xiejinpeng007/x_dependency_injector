import 'package:build/build.dart';
import 'package:x_dependency_injector/generator/inject_entry_generator.dart';
import 'package:x_dependency_injector/generator/inject_use_case_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder injectUseCaseGeneratorBuilder(BuilderOptions options) => LibraryBuilder(
      InjectUseCaseGenerator(),
      generatedExtension: '.inject.json',
      formatOutput: (generated) => generated.replaceAll(RegExp(r'//.*|\s'), ''),
      header: '',
    );

Builder injectEntryGeneratorBuilder(BuilderOptions options) => LibraryBuilder(
      InjectEntryGenerator(),
      generatedExtension: '.inject.dart',
    );
