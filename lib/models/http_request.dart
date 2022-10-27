import 'dart:convert';

import 'package:http/http.dart' as http;

import '../main.dart';

void getUpadteData() async {
  /// Sending request to api for all changes 
  while (true) {
    var locUrl = Uri.parse('http://ussd.uz/update/${ussdBox.get('NEXT_VERSION')}.json');
    var res = await http.get(locUrl);
  

    if (res.statusCode == 200) {
      bool isAvialable = true;
      var datas;
      try {
        datas = jsonDecode(res.body);
      } catch (e) {
        isAvialable = false;
      }

      if (isAvialable && res.body != '{}' && datas != [] && datas != null && res.body != null && res.body != []) {
        var orderLine = datas['order'];
        var n_ver = datas['next_version'];
        datas = datas['data'];

        for (int t = 0; t < orderLine.length; t++) {
          datas[orderLine[t]].forEach((key1, changingDatas) {
            print(key1);

            bool status = false;

            switch (key1) {
              case 'ADD_CHILDREN':
                status = addChildren(orderLine[t], changingDatas);
                break;
              case 'DEL_CHILDREN':
                status = delChildren(orderLine[t], changingDatas);
                break;
              case 'EDIT_CONTENT':
                status = editContent(orderLine[t], changingDatas);
                break;
              case 'SORT':
                status = fastSort(orderLine[t], changingDatas);
                break;
              case 'NEWS':
                status = fastSort(orderLine[t], changingDatas);
                break;
            }
          });
        }

        //updateNewVersion(ussdBox.get('reg_token'), ussdBox.get('NEXT_VERSION'), "");
        ussdBox.put('NEXT_VERSION', n_ver);
        print(ussdBox.get('NEXT_VERSION'));
      } else {
        break;
      }
    } else {
      print("Status code isn't 200 it is equal: ${res.statusCode}");
      break;
    }
  }
var token = ussdBox.get('reg_token');
 // ussdBox.put('old_reg_token', 'fVLpvOiZRvyZbY2NJWfBuz:APA91bEFAqhp-VUigUnxSyqVGh_V9QeaAsElXDJwlb05NzvWv-jmHVXgcvvBIokZBj24tZZ2MucRX3fKu38p7WwkvR3lpdydaPrZv81XTX1Ld7iZtr1eB-S6E0v6uxpgKX-8uPQPGeVa');
  if(ussdBox.get('old_reg_token') == null){
    ussdBox.put('old_reg_token',token);
  }
  if(ussdBox.get('old_reg_token') != token){
    await updateNewVersion(token,ussdBox.get('NEXT_VERSION'),ussdBox.get('old_reg_token'));
    ussdBox.put('old_reg_token',token);
  }else{
    //print('old_reg_token : ${ussdBox.get('old_reg_token')}');
    await updateNewVersion(token,ussdBox.get('NEXT_VERSION'),"");
  }
}

bool addChildren(uId, changingDatas) {
  var data = jsonDecode(ussdBox.get(uId));
  // print(data.length);
  //data.addAll(changingDatas);
  changingDatas.forEach((val) {
    data.insert(0, val);
    ussdBox.put('parent_' + val['id'], uId);
  });

  ussdBox.put(uId, jsonEncode(data));
  return true;
}

bool fastSort(uId, sortData) {
  var data = jsonDecode(ussdBox.get(uId));
  var newSortedData = [];
  // print(data.length);
  for (int j = 0; j < sortData.length; j++) {
    for (int i = 0; i < data.length; i++) {
      if (data[i]['id'] == sortData[j]) {
        newSortedData.add(data[i]);
        data.removeAt(i);
        break;
      }
    }
  }
  newSortedData.addAll(data);

  ussdBox.put(uId, jsonEncode(newSortedData));
  return true;
}

bool delChildren(uId, delIds) {

  var data = jsonDecode(ussdBox.get(uId));
  // print(data.length);
  for (int i = 0; i < delIds.length; i++) {
    for (int j = 0; j < data.length; j++) {
      if (data[j]['id'] == delIds[i]) {
        data.removeAt(j);
        ussdBox.delete('parent_' + delIds[i]);
        break;
      }
    }
  }
  ussdBox.put(uId, jsonEncode(data));
  return true;
}

bool editContent(key, editingData) {

  String parentId = ussdBox.get('parent_' + key).toString();
  var parentData = jsonDecode(ussdBox.get(parentId).toString());
  editingData['id'] = key;

  if (parentData != null && parentData != "") {
    for (int i = 0; i < parentData.length; i++) {
      if (parentData[i]['id'] == key) {
        parentData[i] = editingData;
        break;
      }
    }
    ussdBox.put(parentId, jsonEncode(parentData));
  } else {
    String notParent = ussdBox.get('main_' + key);
    // print(notParent);
    // if(parentData != null){
    ussdBox.put(notParent, jsonEncode(editingData));
    // }
  }

  return true;
}

Future<bool> updateNewVersion(regId, version,oldRegId) async {
  var locUrl = Uri.parse("http://ussd.uz/welcome/create_reg");
  var response = await http.post(locUrl, body: {'regid': regId, 'version': version,'old_regid':oldRegId});

  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
  }
  return true;
}
