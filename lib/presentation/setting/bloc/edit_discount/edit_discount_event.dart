part of 'edit_discount_bloc.dart';

@freezed
class EditDiscountEvent with _$EditDiscountEvent {
  const factory EditDiscountEvent.started() = _Started;
  const factory EditDiscountEvent.editDiscount({
    required String id,
    required String name,
    required String description,
    required double value,
  }) = _EditDiscount;
}
