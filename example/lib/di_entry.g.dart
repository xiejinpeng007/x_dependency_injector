// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectEntryGenerator
// **************************************************************************

import 'package:get/get.dart';
import 'package:example/test_use_case.dart';
import 'package:example/test_repository.dart';
import 'package:example/test_use_case_2.dart';

extension GetXInjectableX on GetInterface {
  void injectDependencies() {
    Get.lazyPut<TestUseCase>(() => TestUseCase(Get.find<TestRepository>()),
        fenix: true);
    Get.lazyPut<TestUseCase2>(() => TestUseCase2(), fenix: true);
  }
}
