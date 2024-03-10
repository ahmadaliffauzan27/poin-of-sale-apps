import 'package:bloc/bloc.dart';
import 'package:flutter_pos_apps/data/models/response/qris_response_model.dart';
import 'package:flutter_pos_apps/data/models/response/qris_status_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'qris_event.dart';
part 'qris_state.dart';
part 'qris_bloc.freezed.dart';

class QrisBloc extends Bloc<QrisEvent, QrisState> {
  QrisBloc() : super(_Initial()) {
    on<QrisEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
