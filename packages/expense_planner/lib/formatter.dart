part of expense_planner;

//Formats the date with weekday e.g
String formatDateWithWeekDay(DateTime dateTime) {
  var dateFormat = DateFormat.yMMMMEEEEd();
  return dateFormat.format(dateTime);
}

//Get the day like Mon, Tue,Wed etc.
String getDayKey(DateTime dateTime) => DateFormat.E().format(dateTime);

//Formats the number with one decimal
String numberFormat(num value) {
  var formatter = NumberFormat("###.##", "en_US");
  return formatter.format(value);
}

//format with decimals
final String Function(num, {int decimals}) formatWithFixedString =
    (num anyNumber, {int decimals = 2}) => anyNumber.toStringAsFixed(decimals);

final String Function(num, int) _formatWithFixedString =
    (num anyNumber, [int decimals = 2]) => anyNumber.toStringAsFixed(decimals);
