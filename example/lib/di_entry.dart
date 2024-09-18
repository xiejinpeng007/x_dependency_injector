



import 'package:example/di_entry.g.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:x_dependency_injector/inject_annotation.dart';

@InjectEntry()
injectDependencies(){
main(){
  Get.injectDependencies();
}
}