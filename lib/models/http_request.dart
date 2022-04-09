import 'dart:convert';

import 'package:http/http.dart' as http;

import '../main.dart';

void getReq() async {

print(ussdBox.get('NEXT_VERSION'));
  var locUrl = Uri.parse('http://ussd.uz/update/${ussdBox.get('NEXT_VERSION')}.json');
  var res = await http.get(locUrl);
  // print(res.body);

  if (res.statusCode == 200) {
    bool isAvialable = true;
    var datas;
    try{
       datas = jsonDecode(res.body);
    }catch(e){
      isAvialable = false;
    }

    if(isAvialable && res.body != '{}' && datas != [] && datas!=null && res.body!=null && res.body!=[]) {
      var orderLine = datas['order'];
      var n_ver = datas['next_version'];
      datas = datas['data'];


      for(int t=0;t<orderLine.length;t++) {

        datas[orderLine[t]].forEach((key1, changingDatas) {
          print(key1);

          bool status = false;

          switch (key1) {
            case 'ADD_CHILDREN':status=addChildren(orderLine[t],changingDatas);break;
            case 'DEL_CHILDREN':status = delChildren(orderLine[t], changingDatas);break;
            case 'EDIT_CONTENT':status = editContent(orderLine[t], changingDatas);break;
            case 'SORT':status=fastSort(orderLine[t] ,changingDatas);break;
          }
        });
      }

      updateNewVersion(ussdBox.get('reg_token'),ussdBox.get('NEXT_VERSION'));
      ussdBox.put('NEXT_VERSION',n_ver);
      print(ussdBox.get('NEXT_VERSION'));
    }
  }
}

bool addChildren(uId, changingDatas) {
  var data = jsonDecode(ussdBox.get(uId));
  // print(data.length);
  //data.addAll(changingDatas);
  changingDatas.forEach((val){
    data.insert(0,val);
    ussdBox.put('parent_'+val['id'], uId);
  });
  // print(data.length);

  ussdBox.put(uId, jsonEncode(data));
  return true;
}

bool fastSort(uId, sortData) {
  var data = jsonDecode(ussdBox.get(uId));
  var newSortedData = [];
//print(sortData);
  print(data.length);
  for (int j = 0; j < sortData.length; j++) {
    // print("salom");
    for (int i = 0; i < data.length; i++) {
      if (data[i]['id'] == sortData[j]) {
        newSortedData.add(data[i]);
        data.removeAt(i);
        break;
      }
    }
  }
  newSortedData.addAll(data);
  print(data.length);

  ussdBox.put(uId, jsonEncode(newSortedData));
  return true;
}

bool delChildren(uId, delIds) {
  //print("del uId = "+uId);
  var data = jsonDecode(ussdBox.get(uId));
  //print(delIds);
  print(data.length);
  for (int i = 0; i < delIds.length; i++) {
    for (int j = 0; j < data.length; j++) {
      if (data[j]['id'] == delIds[i]) {
        data.removeAt(j);
        ussdBox.delete('parent_'+delIds[i]);
        break;
      }
    }
  }
 // printWrapped(jsonEncode(data));
  ussdBox.put(uId, jsonEncode(data));
  return true;
}

bool editContent(key,editingData){
//   print("it is editing data : ");
// print(editingData);

  String parentId = ussdBox.get('parent_'+key).toString();
  var parentData = jsonDecode(ussdBox.get(parentId).toString());
  // var editingData = jsonDecode(editingData);
  editingData['id'] = key;
  print("child id = "+key);
print("parent id = "+parentId);
  if(parentData != null && parentData != ""){
    for(int i=0;i<parentData.length;i++){
      if(parentData[i]['id'] == key){
        parentData[i] = editingData;
        break;
      }
    }
    print(parentId);
    ussdBox.put(parentId, jsonEncode(parentData));
  }else{
     String notParent = ussdBox.get('main_'+key);
     print(notParent);
     // if(parentData != null){
       ussdBox.put(notParent, jsonEncode(editingData));
     // }
  }

  return true;
}


Future<bool> updateNewVersion(regid,version) async {

  var locUrl = Uri.parse("http://ussd.uz/welcome/create_reg");
  var response = await http.post(locUrl, body: {'regid': regid, 'version': version});

  if(response.statusCode == 200){
    print('Response body: ${response.body}');
  }
  return true;
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
