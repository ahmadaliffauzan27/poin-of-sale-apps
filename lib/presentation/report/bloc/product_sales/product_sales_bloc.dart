import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/order_item_remote_datasource.dart';
import '../../../../data/models/response/product_sales_response_model.dart';

part 'product_sales_event.dart';
part 'product_sales_state.dart';
part 'product_sales_bloc.freezed.dart';

class ProductSalesBloc extends Bloc<ProductSalesEvent, ProductSalesState> {
  final OrderItemRemoteDatasource datasource;
  ProductSalesBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_GetProductSales>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getProductSalesByRangeDate(
          event.startDate, event.endDate);
      result.fold((l) => emit(_Error(l)), (r) => emit(_Loaded(r.data!)));
    });
  }
}
