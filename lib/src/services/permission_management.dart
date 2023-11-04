import 'package:permission_handler/permission_handler.dart';

class PermissionManagement{

  static Future<bool> storagePermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    print(statuses[Permission.storage]);

    if (statuses[Permission.storage] == PermissionStatus.granted) {
      return true;
    } else if (statuses[Permission.storage] == PermissionStatus.permanentlyDenied) {
      
      return true;
    } else {
      return false;
    }
  }


  static Future<bool> recordingPermission() async{
    final status = await Permission.microphone.request();
    return status == PermissionStatus.granted;
  }
}