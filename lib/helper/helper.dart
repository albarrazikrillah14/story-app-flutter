class DateHelper {
  String formatDate(String inputDate) {
    try {
      DateTime date = DateTime.parse(inputDate);
      String formattedDate =
          "${date.day} ${_getMonthName(date.month)} ${date.year}";
      return formattedDate;
    } catch (e) {
      print("Error parsing date: $e");
      return "Invalid Date";
    }
  }

  String _getMonthName(int month) {
    List<String> monthNames = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return monthNames[month - 1];
  }
}
