// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter_pos_apps/data/datasources/order_remote_datasource.dart';
import 'package:flutter_pos_apps/data/datasources/product_local_remote_datasource.dart';
import 'package:flutter_pos_apps/presentation/home/models/order_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/response/order_response_model.dart';

part 'transaction_report_event.dart';
part 'transaction_report_state.dart';
part 'transaction_report_bloc.freezed.dart';

class TransactionReportBloc
    extends Bloc<TransactionReportEvent, TransactionReportState> {
  final OrderRemoteDatasource orderRemoteDatasource;
  TransactionReportBloc(
    this.orderRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetReportData>((event, emit) async {
      emit(const _Loading());
      final result = await orderRemoteDatasource.getOrderByRangeDate(
          event.startDate, event.endDate);

      result.fold((l) => emit(_Error(l)), (r) => emit(_Loaded(r.data!)));
    });
  }
}
