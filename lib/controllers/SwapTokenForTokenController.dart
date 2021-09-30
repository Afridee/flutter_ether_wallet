import 'package:get/get.dart';

class SwapTokenForTokenController extends GetxController{
   int minOutPercentage = 0;

   changeMinOutPercentage(int val){
     minOutPercentage = val;
     update();
   }
}