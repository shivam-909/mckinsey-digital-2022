import 'package:html/parser.dart';

class Utils {
  static String stringifyDate(DateTime time) {
    var duration = time.difference(DateTime.now());

    String timeString = "${time.month}/${time.day}";

    if (duration.inHours > 48) {
      ;
    } else if (duration.inHours > 24) {
      timeString = "Tomorrow";
    } else if (duration.inHours <= 24) {
      timeString = "Today";
    }

    // print(duration.inHours.toString() + " " + timeString);
    return timeString;
  }

//here goes the function

  static String parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }
}
