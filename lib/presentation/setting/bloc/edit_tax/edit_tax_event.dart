part of 'edit_tax_bloc.dart';

@freezed
class EditTaxEvent with _$EditTaxEvent {
  const factory EditTaxEvent.started() = _Started;
  const factory EditTaxEvent.editTax({
    required String id,
    required double value,
  }) = _EditTax;
}
