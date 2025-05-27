import 'package:intl/intl.dart';

class Utils {
  static getIntials(String by) {
    String initials = "";
    by.trim().split(" ").forEach((text) {
      initials += text.substring(0, 1).toUpperCase();
    });
    return initials;
  }

  static formatDatetime(int milli) {
    final f = DateFormat('hh:mm le dd-MM-yyyy', 'fr_FR');
    return f.format(DateTime.fromMillisecondsSinceEpoch(milli).toLocal());
  }
}
