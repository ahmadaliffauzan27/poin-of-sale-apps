import 'package:dartz/dartz.dart';
import 'package:flutter_pos_apps/data/datasources/auth_local_remote_datasource.dart';

import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';
import '../models/response/product_response_model.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductResponsesModel>> getProducts() async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-product');
    final authData = await AuthLocalRemoteDatasource().getAuthData();
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      return Right(ProductResponsesModel.fromJson(response.body));
    } else {
      return const Left('Failed to get products');
    }
  }
}
