part of 'delete_tax_bloc.dart';

@freezed
class DeleteTaxState with _$DeleteTaxState {
  const factory DeleteTaxState.initial() = _Initial;
  const factory DeleteTaxState.loading() = _Loading;
  const factory DeleteTaxState.loaded() = _Loaded;
  const factory DeleteTaxState.error(String message) = _Error;
}
