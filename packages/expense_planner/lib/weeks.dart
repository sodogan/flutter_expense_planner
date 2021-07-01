part of expense_planner;

List<DateTime> generateWeekList({DateTime? dateTime}) {
  final startDate = dateTime ?? DateTime.now();

  final _datesList = List.generate(7, (index) {
    final dateFormatted = startDate.subtract(Duration(days: index));
    return dateFormatted;
  });

//sort the list based on date
  _datesList.sort((current, next) => current.compareTo(next));

  return _datesList;
}

//synch generator
List<DateTime> weeklyListGenerator({DateTime? dateTime}) {
  final date = dateTime ?? DateTime.now();

  final _list = _weeklyListGeneratorSync(startDate: date).toList();

  return _list;
}

Iterable<DateTime> _weeklyListGeneratorSync(
    {required DateTime startDate}) sync* {
  for (int i = 0; i < 7; i++) {
    final dateFormatted = startDate.subtract(Duration(days: i));

    yield dateFormatted;
  }
}
