// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter_pos_apps/data/datasources/product_local_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/response/product_response_model.dart';

part 'local_product_event.dart';
part 'local_product_state.dart';
part 'local_product_bloc.freezed.dart';

class LocalProductBloc extends Bloc<LocalProductEvent, LocalProductState> {
  final ProductLocalRemoteDatasource productLocalRemoteDatasource;
  LocalProductBloc(
    this.productLocalRemoteDatasource,
  ) : super(const _Initial()) {
    on<_getLocalProduct>((event, emit) async {
      emit(const _Loading());
      final result = await productLocalRemoteDatasource.getProducts();
      emit(_Loaded(result));
    });
  }
}
