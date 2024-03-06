import 'package:bloc/bloc.dart';
import 'package:flutter_pos_apps/data/datasources/auth_local_remote_datasource.dart';
import 'package:flutter_pos_apps/data/datasources/product_local_remote_datasource.dart';
import 'package:flutter_pos_apps/presentation/home/models/product_qty.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/order_model.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const _Initial()) {
    on<_Order>((event, emit) async {
      emit(const _Loading());

      final subTotal = event.items.fold<int>(
        0,
        (previousValue, element) =>
            previousValue + (element.product.price! * element.quantity),
      );

      final total = subTotal + event.tax + event.serviceCharge - event.discount;

      final totalItem = event.items.fold<int>(
        0,
        (previousValue, element) => previousValue + element.quantity,
      );

      final userData = await AuthLocalRemoteDatasource().getAuthData();
      //save to local storage
      final dataInput = OrderModel(
        subTotal: subTotal,
        paymentAmount: event.paymentAmount,
        tax: event.tax,
        discount: event.discount,
        serviceCharge: event.serviceCharge,
        total: total,
        paymentMethod: 'Cash',
        totalItem: totalItem,
        idKasir: userData.user!.id!,
        namaKasir: userData.user!.name!,
        transactionTime: DateTime.now().toString(),
        isSync: 0,
        orderItems: event.items,
      );

      await ProductLocalRemoteDatasource.instance.saveOrder(dataInput);

      //emit loaded state
      emit(_Loaded(
        dataInput,
      ));
    });
  }
}
