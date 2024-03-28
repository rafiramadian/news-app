import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static String convertDate({
    required String dateString,
    required String dateFormat,
    Duration? addTime,
  }) {
    initializeDateFormatting('id');
    if (dateString == '') return 'TBA';

    DateTime dateTime =
        DateTime.parse(dateString).add(addTime ?? const Duration()).toLocal();
    final String convertedDate = DateFormat(dateFormat, 'id').format(dateTime);

    return convertedDate;
  }
}
