part of 'summary_reports_bloc.dart';

@freezed
class SummaryReportsEvent with _$SummaryReportsEvent {
  const factory SummaryReportsEvent.started() = _Started;
  const factory SummaryReportsEvent.getSummaryReports({
    required String startDate,
    required String endDate,
  }) = _GetSummaryReports;
}
