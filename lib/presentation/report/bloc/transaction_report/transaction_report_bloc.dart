// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter_pos_apps/data/datasources/product_local_remote_datasource.dart';
import 'package:flutter_pos_apps/presentation/home/models/order_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_report_event.dart';
part 'transaction_report_state.dart';
part 'transaction_report_bloc.freezed.dart';

class TransactionReportBloc
    extends Bloc<TransactionReportEvent, TransactionReportState> {
  final ProductLocalRemoteDatasource productLocalRemoteDatasource;
  TransactionReportBloc(
    this.productLocalRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetReportData>((event, emit) async {
      emit(const _Loading());
      final result = await productLocalRemoteDatasource.getAllOrder(
          event.startDate, event.endDate);

      emit(_Loaded(data: result));
    });
  }
}
