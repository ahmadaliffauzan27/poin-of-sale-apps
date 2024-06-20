part of 'history_bloc_bloc.dart';

@freezed
class HistoryBlocState with _$HistoryBlocState {
  const factory HistoryBlocState.initial() = _Initial;
  const factory HistoryBlocState.loading() = _Loading;
  const factory HistoryBlocState.loaded(List<OrderModel> orders) = _Loaded;
}
