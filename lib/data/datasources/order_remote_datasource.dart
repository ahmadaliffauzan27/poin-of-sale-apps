import 'package:flutter_pos_apps/core/constants/variables.dart';
import 'package:http/http.dart' as http;

import '../../presentation/home/models/order_model.dart';
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
}
