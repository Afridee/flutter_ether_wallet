import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthController extends GetxController{

  bool didAuthenticate = false;

  authenticate() async{
    var localAuth = LocalAuthentication();

    bool canCheckBiometrics  = await localAuth.canCheckBiometrics;

    didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        biometricOnly: canCheckBiometrics);
    update();
  }
}