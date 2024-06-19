part of 'add_tax_bloc.dart';

@freezed
class AddTaxEvent with _$AddTaxEvent {
  const factory AddTaxEvent.started() = _Started;
  const factory AddTaxEvent.addDiscount({
    required int value,
  }) = _AddTax;
}
