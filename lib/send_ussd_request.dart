import 'package:ussd_advanced/ussd_advanced.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> sendUssdMessage(code) async{
try{
  await Permission.phone.request();
  if(!await Permission.phone.isGranted){
    throw Exception("Permission deied on this device !");
  }
print(code);
  await UssdAdvanced.sendUssd(code: code);
  print("Successfully dne !");
}catch(e){
  print("error code ${e} - ${e}");
}
}