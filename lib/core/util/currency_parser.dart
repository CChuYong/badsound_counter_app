import 'package:intl/intl.dart';

class CurrencyParser {
  static final formatCurrency =
      NumberFormat.simpleCurrency(locale: "ko_KR", name: "", decimalDigits: 0);

  static String format(int value) {
    return formatCurrency.format(value);
  }
}
