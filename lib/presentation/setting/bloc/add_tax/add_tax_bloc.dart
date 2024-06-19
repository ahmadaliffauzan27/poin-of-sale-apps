import 'package:bloc/bloc.dart';
import 'package:flutter_pos_apps/data/datasources/tax_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_tax_event.dart';
part 'add_tax_state.dart';
part 'add_tax_bloc.freezed.dart';

class AddTaxBloc extends Bloc<AddTaxEvent, AddTaxState> {
  final TaxRemoteDatasource taxRemoteDatasource;
  AddTaxBloc(this.taxRemoteDatasource) : super(const _Initial()) {
    on<_AddTax>((event, emit) async {
      emit(const _Loading());
      final result = await taxRemoteDatasource.addTax(
        event.value,
      );
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
