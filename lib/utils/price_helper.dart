import 'package:intl/intl.dart';

extension ToPriceInt on int {
  String toPrice({String? currency = "RS."}) {
    var formatter =
        NumberFormat.currency(decimalDigits: 0, symbol: "$currency ");
    return formatter.format(this);
  }
}

extension ToPriceDouble on double {
  String toPrice(String currency){
    var formatter = NumberFormat.currency(decimalDigits: 0, symbol: currency);
    return formatter.format(this);
  }
}

extension ToPriceNum on num {
  String toPrice(String currency){
    var formatter = NumberFormat.currency(decimalDigits: 0, symbol: currency);
    return formatter.format(this);
  }
}
