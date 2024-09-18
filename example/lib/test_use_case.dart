import 'package:example/test_repository.dart';
import 'package:x_dependency_injector/inject_annotation.dart';

@InjectUseCase()
class TestUseCase {
  TestUseCase(this.testRepository);

  final TestRepository testRepository;
}
