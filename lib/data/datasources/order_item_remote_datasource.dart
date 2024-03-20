import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:dartz/dartz.dart';

import '../../core/constants/variables.dart';
import '../models/response/item_sales_model.dart';
import '../models/response/product_sales_response_model.dart';
import 'auth_local_remote_datasource.dart';

class OrderItemRemoteDatasource {
  Future<Either<String, ItemSalesResponseModel>> getItemSalesByRangeDate(
    String stratDate,
    String endDate,
  ) async {
    try {
      final authData = await AuthLocalRemoteDatasource().getAuthData();
      final response = await http.get(
        Uri.parse(
            '${Variables.baseUrl}/api/order-item?start_date=$stratDate&end_date=$endDate'),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      log("Response: ${response.statusCode}");
      log("Response: ${response.body}");
      if (response.statusCode == 200) {
        return Right(ItemSalesResponseModel.fromJson(response.body));
      } else {
        return const Left("Failed Load Data");
      }
    } catch (e) {
      log("Error: $e");
      return Left("Failed: $e");
    }
  }

  Future<Either<String, ProductSalesResponseModel>> getProductSalesByRangeDate(
    String stratDate,
    String endDate,
  ) async {
    try {
      final authData = await AuthLocalRemoteDatasource().getAuthData();
      final response = await http.get(
        Uri.parse(
            '${Variables.baseUrl}/api/order-sales?start_date=$stratDate&end_date=$endDate'),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      log("Response: ${response.statusCode}");
      log("Response: ${response.body}");
      if (response.statusCode == 200) {
        return Right(ProductSalesResponseModel.fromJson(response.body));
      } else {
        return const Left("Failed Load Data");
      }
    } catch (e) {
      log("Error: $e");
      return Left("Failed: $e");
    }
  }
}
