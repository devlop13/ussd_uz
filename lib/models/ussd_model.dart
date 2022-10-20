import 'package:hive_flutter/hive_flutter.dart';

class UssdModel {
  late Box ussdBox;

  UssdModel(){
    ussdBox = Hive.box('ussdBox');
  }

  Future<Map<String,dynamic>> getUms()async{
    Box ussdBox = await Hive.openBox('ussdBox');

    return ussdBox.get('UMS');
  }

  Future<Map> getUzmobile() async {
    ussdBox = Hive.box('ussdBox');
    return ussdBox.get('UZMOBILE');
  }

  Future<Map<String, dynamic>> getBeeline() async {
    ussdBox = Hive.box('ussdBox');
    return ussdBox.get('BEELINE');
  }


  Future<Map<String, dynamic>> getUcell() async {
    ussdBox = Hive.box('ussdBox');
    return ussdBox.get('UCELL');
  }

  Box getBox() {
    return ussdBox;
  }

  Future<void> _write(index, data) async {
    await ussdBox.put(index, data);
  }

  Future<void> _delete(index) async {
    await ussdBox.delete(index);
  }

  Future<void> _update(index, data) async {
    await ussdBox.put(index, data);
  }
}
