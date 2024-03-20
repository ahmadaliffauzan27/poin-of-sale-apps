import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_pos_apps/core/constants/variables.dart';
import 'package:flutter_pos_apps/data/models/response/order_response_model.dart';
import 'package:http/http.dart' as http;

import '../../presentation/home/models/order_model.dart';
import '../models/response/summary_response_model.dart';
import 'auth_local_remote_datasource.dart';

class OrderRemoteDatasource {
  //save order
  Future<bool> saveOrder(OrderModel orderModel) async {
    final authData = await AuthLocalRemoteDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/api-order'),
      body: orderModel.toJson(),
      headers: {
        'Authorization': 'Bearer ${authData.token}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Either<String, OrderResponsesModel>> getOrderByRangeDate(
    String stratDate,
    String endDate,
  ) async {
    final authData = await AuthLocalRemoteDatasource().getAuthData();
    final response = await http.get(
      Uri.parse(
          '${Variables.baseUrl}/api/orders?start_date=$stratDate&end_date=$endDate'),
      headers: {
        'Authorization': 'Bearer ${authData.token}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    log("Response: ${response.statusCode}");
    log("Response: ${response.body}");
    if (response.statusCode == 200) {
      return Right(OrderResponsesModel.fromJson(response.body));
    } else {
      return const Left("Failed Load Data");
    }
  }

  Future<Either<String, SummaryResponseModel>> getSummaryByRangeDate(
    String stratDate,
    String endDate,
  ) async {
    try {
      final authData = await AuthLocalRemoteDatasource().getAuthData();
      final response = await http.get(
        Uri.parse(
            '${Variables.baseUrl}/api/summary?start_date=$stratDate&end_date=$endDate'),
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      log("Response: ${response.statusCode}");
      log("Response: ${response.body}");
      if (response.statusCode == 200) {
        return Right(SummaryResponseModel.fromJson(response.body));
      } else {
        return const Left("Failed Load Data");
      }
    } catch (e) {
      // log("Error: $e");
      return Left("Failed: $e");
    }
  }
}
