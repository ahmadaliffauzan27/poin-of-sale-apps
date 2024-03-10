part of 'qris_bloc.dart';

@freezed
class QrisState with _$QrisState {
  const factory QrisState.initial() = _Initial;
  const factory QrisState.loading() = _Loading;
  //qris response
  const factory QrisState.qrisResponse(QrisResponseModel qrisResponseModel) =
      _QrisResponse;
  //success
  const factory QrisState.success(String message) = _Success;
  //error
  const factory QrisState.error(String message) = _Error;
  //check status
  const factory QrisState.checkStatus(
      QrisStatusResponseModel qrisStatusResponseModel) = _CheckStatus;
}
