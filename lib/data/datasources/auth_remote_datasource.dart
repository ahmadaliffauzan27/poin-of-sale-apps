import 'package:dartz/dartz.dart';
import 'package:flutter_pos_apps/core/constants/variables.dart';
import 'package:http/http.dart' as http;

import '../models/response/auth_response_model.dart';
import 'auth_local_remote_datasource.dart';

class AuthRemoteDatasource {
  //login
  Future<Either<String, AuthResponsesModel>> login(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return Right(AuthResponsesModel.fromJson(response.body));
    } else {
      return const Left('Gagal login');
    }
  }

  //logout
  Future<Either<String, bool>> logout() async {
    final authData = await AuthLocalRemoteDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/logout');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${authData.token}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return const Left('Gagal logout');
    }
  }
}
