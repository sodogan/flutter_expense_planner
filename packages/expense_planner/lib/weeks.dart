part of expense_planner;

List<DateTime> generateWeekList({DateTime? dateTime}) {
  final startDate = dateTime == null ? DateTime.now() : dateTime;

  return List.generate(7, (index) {
    final dateFormatted = startDate.subtract(Duration(days: index));
    return dateFormatted;
  });
}
