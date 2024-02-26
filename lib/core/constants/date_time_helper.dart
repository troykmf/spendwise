String convertDateTimeToString(DateTime dateTime) {
  String year = dateTime.year.toString();

  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  final ddmmyyyy = day + month + year;

  return ddmmyyyy;
}

// calculate the number of month since the first start month

int calculateMonthCount(int startYear, startMonth, currentYear, currentMonth) {
  int monthCount =
      (currentYear - startYear) * 12 + currentMonth - startMonth + 1;

  return monthCount;
}
