import 'package:dartz/dartz.dart';
import 'package:flutter_pos_apps/data/datasources/auth_local_remote_datasource.dart';
import 'package:flutter_pos_apps/data/models/response/tax_response_model.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';

class TaxRemoteDatasource {
  Future<Either<String, TaxResponsesModel>> getTaxs() async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-pajak');
    final authData = await AuthLocalRemoteDatasource().getAuthData();
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${authData.token}',
        'Accept': 'application/json',
      },
    );

    // if (response.statusCode == 200) {
    //   return Right(TaxResponsesModel.fromJson(response.body));
    // } else {
    //   return const Left('Failed to load tax');
    // }
    try {
      if (response.statusCode == 200) {
        return Right(TaxResponsesModel.fromJson(response.body));
      } else {
        return const Left('Failed to load tax');
      }
    } catch (e) {
      // Handle any exceptions that might occur
      print('Exception occurred: $e');
      return const Left('Failed to load tax');
    }
  }

  //add tax
  Future<Either<String, bool>> addTax(int value) async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-pajaks');
    final authData = await AuthLocalRemoteDatasource().getAuthData();
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
    }, body: {
      'value': value.toString(),
    });

    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return const Left('Gagal menambahkan pajak');
    }
  }

  Future<Either<String, bool>> editTax(
    String id,
    double value,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-pajaks/$id');
    final authData = await AuthLocalRemoteDatasource().getAuthData();
    final response = await http.put(url, headers: {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
    }, body: {
      'value': value.toString(),
    });

    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return const Left('Failed to add tax');
    }
  }

  Future<Either<String, bool>> deleteTax(
    String id,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-pajaks/$id');
    final authData = await AuthLocalRemoteDatasource().getAuthData();
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer ${authData.token}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return const Left('Failed to delete tax');
    }
  }
}
