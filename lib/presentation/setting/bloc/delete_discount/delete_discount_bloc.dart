import 'package:bloc/bloc.dart';
import 'package:flutter_pos_apps/data/datasources/discount_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_discount_event.dart';
part 'delete_discount_state.dart';
part 'delete_discount_bloc.freezed.dart';

class DeleteDiscountBloc
    extends Bloc<DeleteDiscountEvent, DeleteDiscountState> {
  final DiscountRemoteDatasource discountRemoteDatasource;
  DeleteDiscountBloc(this.discountRemoteDatasource) : super(const _Initial()) {
    on<_DeleteDiscount>((event, emit) async {
      final result = await discountRemoteDatasource.deleteDiscount(event.id);
      result.fold((l) => emit(_Error(l)), (r) => emit(const _Loaded()));
    });
  }
}
