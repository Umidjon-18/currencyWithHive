import 'dart:io';
import 'package:colorize/colorize.dart';

class Utils {
  void printModel(Colorize text) {
    print(greenColor(
        '''-----------------------------------------------------------------------
|                                                                     |'''));
    print("  $text");
    print(greenColor(
        '''|                                                                     |
-----------------------------------------------------------------------'''));
  }

  Colorize greenColor(String text) {
    return Colorize(text).green();
  }

  Colorize redColor(String text) {
    return Colorize(text).red();
  }

  clear() {
    print(Process.runSync("clear", [], runInShell: true).stdout);
  }
}

extension MyDateExtension on DateTime {
  DateTime getDateOnly(){
    return DateTime(this.year, this.month, this.day);
  }
}
