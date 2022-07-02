import 'package:intl/intl.dart';

String getProductPrice(Map<String, dynamic> price) {
  final formatter = NumberFormat('#,###');

  if (price['value'] > 1000) {
    return '${formatter.format(price['value'])}'.replaceAll(',', ' ');
  }

  return '${price['value']}';
}
