import 'package:flutter_pos_apps/data/models/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalRemoteDatasource {
  Future<void> saveAuthData(AuthResponsesModel authResponsesModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_data', authResponsesModel.toJson());
  }

  Future<void> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_data');
  }

  Future<AuthResponsesModel> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_data');

    return AuthResponsesModel.fromJson(authData!);
  }

  Future<bool> isAuthDataExist() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_data');
  }
}
