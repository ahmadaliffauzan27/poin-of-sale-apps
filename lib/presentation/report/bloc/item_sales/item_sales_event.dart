part of 'item_sales_bloc.dart';

@freezed
class ItemSalesEvent with _$ItemSalesEvent {
  const factory ItemSalesEvent.started() = _Started;
  //get item sales
  const factory ItemSalesEvent.getItemSales({
    required String startDate,
    required String endDate,
  }) = _GetItemSales;
}
