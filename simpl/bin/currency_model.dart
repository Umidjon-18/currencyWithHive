import 'dart:convert';

class CurrencyModel {
  String? curName;
  String? curIcon;
  double? price;

  CurrencyModel({this.curName, this.curIcon, this.price});

  @override
  String toString() {
    return 'CurrencyModel(curName: $curName, curIcon: $curIcon, price: $price)';
  }

  factory CurrencyModel.fromMap(Map data) => CurrencyModel(
        curName: data['curName'] as String?,
        curIcon: data['curIcon'] as String?,
        price: (data['price'] as num?)?.toDouble(),
      );

  Map toMap() => {
        'curName': curName,
        'curIcon': curIcon,
        'price': price,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CurrencyModel].
  factory CurrencyModel.fromJson(String data) {
    return CurrencyModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CurrencyModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
