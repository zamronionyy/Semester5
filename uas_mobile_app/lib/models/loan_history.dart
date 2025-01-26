// TODO Implement this library.// lib/models/loan_history.dart
class LoanHistory {
  final String borrowerName;
  final DateTime loanDate;
  final DateTime returnDate;

  LoanHistory({
    required this.borrowerName,
    required this.loanDate,
    required this.returnDate,
  });
}
