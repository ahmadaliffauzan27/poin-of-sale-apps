part of 'history_bloc_bloc.dart';

@freezed
class HistoryBlocEvent with _$HistoryBlocEvent {
  const factory HistoryBlocEvent.started() = _Started;
  const factory HistoryBlocEvent.loadHistory() = _LoadHistory;
}
