part of 'transaction_report_bloc.dart';

@freezed
class TransactionReportEvent with _$TransactionReportEvent {
  const factory TransactionReportEvent.started() = _Started;
  const factory TransactionReportEvent.getReportData({
    required DateTime startDate,
    required DateTime endDate,
  }) = _GetReportData;
}
