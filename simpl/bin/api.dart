import 'dart:io';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class API {
  connectAPI(currencyBox) async {
    var response = await http.get(Uri.parse('https://pokur.su/usd/'));
    if (response.statusCode == 200) {
      var document = parse(response.body)
          .getElementsByClassName(
              "all-currency-rates-table table table-bordered table-hover table-condensed")[0]
          .getElementsByTagName("tbody")[0]
          .getElementsByTagName("tr");
      var price = document
          .map((e) => e
              .getElementsByTagName("a")[1]
              .text
              .replaceAll(",", ".")
              .replaceAll(" ", ""))
          .toList();
      var curIcon = document
          .map((e) => e.getElementsByTagName("img")[0].attributes["src"])
          .toList();
      var curName =
          document.map((e) => e.getElementsByTagName("a")[0].text).toList();
      var curCode = document
          .map((e) => e.getElementsByTagName("td")[2].text.toLowerCase())
          .toList();

      for (int i = 0; i < 179; i++) {
        var object = {
          "curName": curName[i],
          "price": price[i],
          "curIcon": curIcon[i]
        };
        currencyBox.put(curCode[i], jsonEncode(object));
        currencyBox.put("date",
            "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}");
      }
    } else {
      print("Ulanishda xatolik bor\n\n Status Code : ${response.statusCode}");
    }
  }

  curType() async {
    var today =
        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
    var curObject = {};
    var currencyBoxName = "currency_box";
    var currencyBox = await Hive.openBox(currencyBoxName);
    if (currencyBox.get("date") == today) {
      currencyBox.keys.forEach((element) {
        if (element != "date") {
          curObject.addAll({
            element: double.parse(jsonDecode(currencyBox.get(element))["price"])
          });
        }
      });
      currencyBox.close();
    } else {
      await connectAPI(currencyBox);
      currencyBox.keys.forEach((element) {
        if (element != "date") {
          curObject.addAll({
            element: double.parse(jsonDecode(currencyBox.get(element))["price"])
          });
        }
      });
      currencyBox.close();
    }
    return curObject;
  }
}
