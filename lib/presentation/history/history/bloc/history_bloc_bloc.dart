import 'package:bloc/bloc.dart';
import 'package:flutter_pos_apps/data/datasources/product_local_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../home/models/order_model.dart';

part 'history_bloc_event.dart';
part 'history_bloc_state.dart';
part 'history_bloc_bloc.freezed.dart';

class HistoryBlocBloc extends Bloc<HistoryBlocEvent, HistoryBlocState> {
  final ProductLocalRemoteDatasource productLocalRemoteDatasource;
  HistoryBlocBloc(this.productLocalRemoteDatasource) : super(const _Initial()) {
    on<_LoadHistory>((event, emit) async {
      emit(const _Loading());
      final result = await productLocalRemoteDatasource.getAllOrder();
      emit(_Loaded(result));
    });
  }
}
