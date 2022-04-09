import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ussd_uz/main.dart';


class FromJson {
  Future<void> writeHive() async {

    print("Hey new data !!!");
    String allData = await rootBundle.loadString('assets/jsons/app_cache.json');
    Map<String, dynamic> data = jsonDecode(allData);

    Box ussdBox = await Hive.box('ussdBox');

    await ussdBox.put('NEXT_VERSION', data['version']);

    data = data['data'] as Map<String, dynamic>;

    // for(int i=0;i<data.length-1;i++){
    //     Map<String,dynamic> ussd = {'id':data['UMS']['id']};
    // }

    data.forEach((key, ussd) {
      if (key == 'UMS' ||
          key == 'BEELINE' ||
          key == 'UZMOBILE' ||
          key == 'UCELL') {
        Map<String, dynamic> ussdData = {
          'id': ussd['id'],
          'name': ussd['name'],
          'name_ru': ussd['name_ru'],
          'code': ussd['code'],
        };

        ussdBox.put(key, jsonEncode(ussdData));
        ussdBox.put('main_'+ussd['id'], key);

        List<dynamic> services = ussd['services'];

        List<dynamic> mainServ = [];
        int i = 0;

        services.forEach((service) {
          // USSD SERVICE 1

          List<dynamic> services1 = service.remove('services') ?? [];

          ussdBox.put('parent_'+service['id'],ussd['id']);

          mainServ.add(service);

          if (services1 != []) {
            // String parent1_id = services1['id'];
            List<dynamic> miniServ1 = [];
            services1.forEach((service1) {
              //USSD SERVICE SERVICE 2

              List<dynamic> services2 = service1.remove('services') ?? [];
              ussdBox.put('parent_'+service1['id'],service['id']);
              miniServ1.add(service1);

              if (services2 != []) {
                List<dynamic> miniServ2 = [];
                services2.forEach((service2) {
                  //USSD SERVICE SERVICE 3
                  List<dynamic> services3 = service2.remove('services') ?? [];
                  ussdBox.put('parent_'+service2['id'],service1['id']);
                  miniServ2.add(service2);

                  if (services3 != []) {
                    List<dynamic> miniServ3 = [];
                    services3.forEach((service3) {
                      //USSD SERVICE SERVICE 4
                      List<dynamic> services4 = service3.remove('services') ?? [];
                      ussdBox.put('parent_'+service3['id'],service2['id']);
                      miniServ3.add(service3);

                      if (services4 != []) {
                        List<dynamic> miniServ4 = [];
                        services4.forEach((service4) {
                          //USSD SERVICE SERVICE 4
                          List<dynamic> services5 = service4.remove('services') ?? [];
                          ussdBox.put('parent_'+service4['id'],service3['id']);
                          miniServ4.add(service4);
                        });
                        ussdBox.put(service3['id'], jsonEncode(miniServ4));
                      }
                    });
                    ussdBox.put(service2['id'], jsonEncode(miniServ3));
                  }
                });
                ussdBox.put(service1['id'], jsonEncode(miniServ2));
              }
              // print(services2);
            });
            ussdBox.put(service['id'], jsonEncode(miniServ1));
          }
        });
        // print(mainServ);
        ussdBox.put(ussd['id'], jsonEncode(mainServ));

      }
    });

    // ussdBox.put('ums', jsonEncode(data['data']['UMS']));
    // ussdBox.put('ucell', jsonEncode(data['data']['UCELL']));
    // ussdBox.put('beeline', jsonEncode(data['data']['BEELINE']));
    // ussdBox.put('uzmobile', jsonEncode(data['data']['UZMOBILE']));
    print('done !!!');
  }

}
