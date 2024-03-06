import 'package:dartz/dartz.dart';
import 'package:flutter_pos_apps/data/datasources/auth_local_remote_datasource.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';
import '../models/response/discount_response_model.dart';

class DiscountRemoteDatasource {
  Future<Either<String, DiscountResponsesModel>> getDiscounts() async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-discount');
    final authData = await AuthLocalRemoteDatasource().getAuthData();
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${authData.token}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(DiscountResponsesModel.fromJson(response.body));
    } else {
      return const Left('Failed to load discounts');
    }
  }

  //add diskon
  Future<Either<String, bool>> addDiscount(
      String name, String description, int value) async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-discount');
    final authData = await AuthLocalRemoteDatasource().getAuthData();
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
    }, body: {
      'name': name,
      'description': description,
      'value': value.toString(),
      'type': 'percentage',
    });

    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return const Left('Gagal menambahkan diskon');
    }
  }
}
