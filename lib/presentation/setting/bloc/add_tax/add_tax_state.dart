part of 'add_tax_bloc.dart';

@freezed
class AddTaxState with _$AddTaxState {
  const factory AddTaxState.initial() = _Initial;
  const factory AddTaxState.loading() = _Loading;
  const factory AddTaxState.success() = _Success;
  const factory AddTaxState.error(String message) = _Error;
}
