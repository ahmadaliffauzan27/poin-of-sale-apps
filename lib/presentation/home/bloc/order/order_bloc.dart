// ignore: depend_on_referenced_packages

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter_pos_apps/data/datasources/auth_local_remote_datasource.dart';
import 'package:flutter_pos_apps/data/datasources/product_local_remote_datasource.dart';
import 'package:flutter_pos_apps/presentation/home/models/product_qty.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

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

      final discount = (event.discount / 100) * subTotal;

      final total =
          ((subTotal + event.tax + event.serviceCharge - discount) / 1000)
                  .round()
                  .toInt() *
              1000;

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
        total: total.toInt(),
        paymentMethod: event.paymentMethod,
        totalItem: totalItem,
        idKasir: userData.user!.id!,
        namaKasir: userData.user!.name!,
        transactionTime: DateFormat.yMd().format(DateTime.now()),
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
