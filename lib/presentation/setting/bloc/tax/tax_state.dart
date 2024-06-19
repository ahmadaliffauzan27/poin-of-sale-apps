part of 'tax_bloc.dart';

@freezed
class TaxState with _$TaxState {
  const factory TaxState.initial() = _Initial;
  const factory TaxState.loading() = _Loading;
  const factory TaxState.loaded(List<Tax> tax) = _Loaded;
  const factory TaxState.error(String message) = _Error;
}
