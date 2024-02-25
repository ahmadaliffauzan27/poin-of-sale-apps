// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_pos_apps/data/models/response/product_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_pos_apps/data/datasources/order_remote_datasource.dart';

import '../../../../data/datasources/product_local_remote_datasource.dart';

part 'sync_order_bloc.freezed.dart';
part 'sync_order_event.dart';
part 'sync_order_state.dart';

class SyncOrderBloc extends Bloc<SyncOrderEvent, SyncOrderState> {
  final OrderRemoteDatasource orderRemoteDatasource;
  SyncOrderBloc(
    this.orderRemoteDatasource,
  ) : super(const _Initial()) {
    on<SyncOrderEvent>((event, emit) async {
      emit(const _Loading());
      final dataOrderNotSynced =
          await ProductLocalRemoteDatasource.instance.getOrderByIsNotSync();

      for (var order in dataOrderNotSynced) {
        final orderItem = await ProductLocalRemoteDatasource.instance
            .getOrderItemByOrderId(order.id!);

        final newOrder = order.copyWith(orderItems: orderItem);

        final result = await orderRemoteDatasource.saveOrder(newOrder);
        if (result) {
          await ProductLocalRemoteDatasource.instance
              .updateOrderIsSync(order.id!);
        } else {
          emit(const _Error('Failed to sync order'));
          return;
        }
      }

      emit(const _Loaded());
    });
  }
}
