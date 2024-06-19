import 'package:bloc/bloc.dart';
import 'package:flutter_pos_apps/data/datasources/tax_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_tax_event.dart';
part 'delete_tax_state.dart';
part 'delete_tax_bloc.freezed.dart';

class DeleteTaxBloc extends Bloc<DeleteTaxEvent, DeleteTaxState> {
  final TaxRemoteDatasource taxRemoteDatasource;
  DeleteTaxBloc(this.taxRemoteDatasource) : super(const _Initial()) {
    on<_DeleteTax>((event, emit) async {
      final result = await taxRemoteDatasource.deleteTax(event.id);
      result.fold((l) => emit(_Error(l)), (r) => emit(const _Loaded()));
    });
  }
}
