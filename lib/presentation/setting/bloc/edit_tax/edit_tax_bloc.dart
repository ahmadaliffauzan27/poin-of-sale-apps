import 'package:bloc/bloc.dart';
import 'package:flutter_pos_apps/data/datasources/tax_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_tax_event.dart';
part 'edit_tax_state.dart';
part 'edit_tax_bloc.freezed.dart';

class EditTaxBloc extends Bloc<EditTaxEvent, EditTaxState> {
  final TaxRemoteDatasource taxRemoteDatasource;
  EditTaxBloc(this.taxRemoteDatasource) : super(const _Initial()) {
    on<_EditTax>((event, emit) async {
      emit(const _Loading());
      final result = await taxRemoteDatasource.editTax(event.id, event.value);
      result.fold((l) => emit(_Error(l)), (r) => emit(const _Success()));
    });
  }
}
