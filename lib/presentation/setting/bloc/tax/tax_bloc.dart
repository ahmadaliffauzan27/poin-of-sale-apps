import 'package:bloc/bloc.dart';
import 'package:flutter_pos_apps/data/datasources/tax_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/response/tax_response_model.dart';

part 'tax_event.dart';
part 'tax_state.dart';
part 'tax_bloc.freezed.dart';

class TaxBloc extends Bloc<TaxEvent, TaxState> {
  final TaxRemoteDatasource taxRemoteDatasource;
  TaxBloc(this.taxRemoteDatasource) : super(const _Initial()) {
    on<_GetTaxs>((event, emit) async {
      emit(const _Loading());
      final result = await taxRemoteDatasource.getTaxs();
      result.fold((l) => emit(_Error(l)), (r) => emit(_Loaded(r.data!)));
    });
  }
}
