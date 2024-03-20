import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/order_remote_datasource.dart';
import '../../../../data/models/response/summary_response_model.dart';

part 'summary_reports_event.dart';
part 'summary_reports_state.dart';
part 'summary_reports_bloc.freezed.dart';

class SummaryReportBloc extends Bloc<SummaryReportsEvent, SummaryReportsState> {
  final OrderRemoteDatasource datasource;
  SummaryReportBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_GetSummaryReports>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getSummaryByRangeDate(
          event.startDate, event.endDate);
      result.fold((l) => emit(_Error(l)), (r) => emit(_Loaded(r.data!)));
    });
  }
}
