part of 'local_product_bloc.dart';

@freezed
class LocalProductEvent with _$LocalProductEvent {
  const factory LocalProductEvent.started() = _Started;
  const factory LocalProductEvent.getLocalProduct() = _getLocalProduct;
  //search product
  const factory LocalProductEvent.searchProduct({required String query}) =
      _SearchProduct;
}
