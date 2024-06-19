part of 'edit_tax_bloc.dart';

@freezed
class EditTaxState with _$EditTaxState {
  const factory EditTaxState.initial() = _Initial;
  const factory EditTaxState.loading() = _Loading;
  const factory EditTaxState.error(String message) = _Error;
  const factory EditTaxState.success() = _Success;
}
