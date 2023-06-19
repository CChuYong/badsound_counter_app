import 'package:intl/intl.dart';

class CurrencyParser {
  static final formatCurrency = NumberFormat('###,###,###,###원');

  static String format(int value) {
    final String formattedCurrency = value < 0 ? '- ' : '+ ';
    return formattedCurrency + formatCurrency.format(value);
  }
}
