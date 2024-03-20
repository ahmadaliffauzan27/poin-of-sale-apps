// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_pos_apps/presentation/home/models/order_item.dart';

import '../../../../data/datasources/order_item_remote_datasource.dart';
import '../../../../data/models/response/item_sales_model.dart';

part 'item_sales_bloc.freezed.dart';
part 'item_sales_event.dart';
part 'item_sales_state.dart';

class ItemSalesBloc extends Bloc<ItemSalesEvent, ItemSalesState> {
  final OrderItemRemoteDatasource orderItemRemoteDatasource;
  ItemSalesBloc(
    this.orderItemRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetItemSales>((event, emit) async {
      emit(const _Loading());
      final result = await orderItemRemoteDatasource.getItemSalesByRangeDate(
          event.startDate, event.endDate);

      result.fold((l) => emit(_Error(l)), (r) => emit(_Loaded(r.data!)));
    });
  }
}
