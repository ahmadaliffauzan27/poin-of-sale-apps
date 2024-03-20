part of 'summary_reports_bloc.dart';

@freezed
class SummaryReportsState with _$SummaryReportsState {
  const factory SummaryReportsState.initial() = _Initial;
  const factory SummaryReportsState.loading() = _Loading;
  const factory SummaryReportsState.error(String message) = _Error;
  const factory SummaryReportsState.loaded(SummaryModel data) = _Loaded;
}
