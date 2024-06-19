part of 'delete_tax_bloc.dart';

@freezed
class DeleteTaxEvent with _$DeleteTaxEvent {
  const factory DeleteTaxEvent.started() = _Started;
  const factory DeleteTaxEvent.deleteTax(String id) = _DeleteTax;
}
