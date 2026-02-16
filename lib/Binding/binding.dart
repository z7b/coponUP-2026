import 'package:coppon_3pp/PageFile/MyHomePage/MyHomePageController.dart';
import 'package:get/get.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MyHomePageControlle() , fenix: true);
  }

}