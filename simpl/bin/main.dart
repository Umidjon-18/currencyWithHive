import 'api.dart';
import 'app.dart';
import 'package:hive/hive.dart';

void main(List<String> arguments) async {
  Hive.init("../src");
  App().currencyConverter();
}
