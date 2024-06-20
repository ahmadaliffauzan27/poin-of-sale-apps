import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_apps/core/core.dart';
import 'package:flutter_pos_apps/core/extensions/int_ext.dart';
import 'package:flutter_pos_apps/presentation/home/bloc/order/order_bloc.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../data/dataoutputs/print_dataoutputs.dart';
import '../../../data/datasources/auth_local_remote_datasource.dart';
import '../../home/bloc/checkout/checkout_bloc.dart';
import '../../home/models/order_model.dart';
import '../../home/models/product_qty.dart';

class HistoryWidget extends StatelessWidget {
  // final String title;
  // final String searchDateFormatted;
  final List<OrderModel> orders;
  final List<Widget>? headerWidgets;
  const HistoryWidget({
    super.key,
    required this.orders,
    // required this.title,
    // required this.searchDateFormatted,
    required this.headerWidgets,
  });

  // dialogProducts(BuildContext context, List<ProductQuantity> products) async {
  //   log("products: ${products.length}");
  //   await showDialog<void>(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Products'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('List Products'),
  //               ...products.map(
  //                 (e) {
  //                   return Row(
  //                     children: [
  //                       Text(
  //                         e.product!.name!,
  //                         style: TextStyle(
  //                           fontSize: 14.0,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //                 },
  //               ).toList()
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text("Ok"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SpaceHeight(16.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: HorizontalDataTable(
                leftHandSideColumnWidth: 40,
                rightHandSideColumnWidth: 1280,
                isFixedHeader: true,
                headerWidgets: headerWidgets,
                // isFixedFooter: true,
                // footerWidgets: _getTitleWidget(),
                leftSideItemBuilder: (context, index) {
                  return Container(
                    width: 40,
                    height: 52,
                    alignment: Alignment.centerLeft,
                    child: Center(child: Text(orders[index].id.toString())),
                  );
                },
                rightSideItemBuilder: (context, index) {
                  return Row(
                    children: <Widget>[
                      // nama menu
                      // Container(
                      //   width: 150,
                      //   height: 52,
                      //   padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      //   alignment: Alignment.centerLeft,
                      //   child: Center(
                      //     child: BlocBuilder<OrderBloc, OrderState>(
                      //       builder: (context, state) {
                      //         List<ProductQuantity> items = state.maybeWhen(
                      //           orElse: () => [],
                      //           loaded: (model) => model.orderItems,
                      //         );

                      //         return Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: items.map((item) {
                      //             return Text(item.product.name!);
                      //           }).toList(),
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),
                      Container(
                        width: 120,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                            child: Text(
                          orders[index].paymentAmount.currencyFormatRp,
                        )),
                      ),
                      Container(
                        width: 120,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                            child: Text(
                          orders[index].subTotal.currencyFormatRp,
                        )),
                      ),
                      Container(
                        width: 120,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text(
                            orders[index].tax.currencyFormatRp,
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text(
                            orders[index].discount.currencyFormatRp,
                          ),
                        ),
                      ),
                      // Container(
                      //   width: 120,
                      //   height: 52,
                      //   padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      //   alignment: Alignment.centerLeft,
                      //   child: Center(
                      //     child: Text(
                      //         orders[index].discountAmount.currencyFormatRp),
                      //   ),
                      // ),
                      // Container(
                      //   width: 120,
                      //   height: 52,
                      //   padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      //   alignment: Alignment.centerLeft,
                      //   child: Center(
                      //     child: Text(
                      //         orders[index].serviceCharge.currencyFormatRp),
                      //   ),
                      // ),
                      Container(
                        width: 120,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text(orders[index].total.currencyFormatRp),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text(orders[index].paymentMethod),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text(orders[index].totalItem.toString()),
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text(orders[index].namaKasir),
                        ),
                      ),
                      Container(
                        width: 230,
                        height: 52,
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Center(
                          child: Text(orders[index].transactionTime.toString()),
                        ),
                      ),
                      // Container(
                      //   width: 120,
                      //   height: 52,
                      //   padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      //   alignment: Alignment.centerLeft,
                      //   child: Center(
                      //       child: ElevatedButton(
                      //           onPressed: () {
                      //             dialogProducts(
                      //                 context, orders[index].orderItems);
                      //           },
                      //           child: Text("Products"))),
                      // ),
                      BlocBuilder<OrderBloc, OrderState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () => const SizedBox(),
                            loaded: (orderModel) => Flexible(
                              child: Button.filled(
                                onPressed: () async {
                                  //get nama kasir from shared preferences
                                  final namaKasir =
                                      await AuthLocalRemoteDatasource()
                                          .getAuthData();
                                  List<ProductQuantity> items = state.maybeWhen(
                                    orElse: () => [],
                                    loaded: (model) => model.orderItems,
                                  );

                                  final printValue = await PrintDataoutputs
                                      .instance
                                      .printOrder(
                                    orders[index].orderItems,
                                    orders[index].totalItem,
                                    orders[index].subTotal,
                                    orders[index].paymentMethod,
                                    orders[index].paymentAmount,
                                    orders[index].paymentAmount,
                                    namaKasir.user!.name!,
                                    orders[index].discount,
                                    orders[index].tax,
                                    orders[index].subTotal,
                                    orders[index].subTotal,
                                  );
                                  await PrintBluetoothThermal.writeBytes(
                                      printValue);

                                  print('data: ${orders[index].orderItems}');
                                  //print model.orderItems
                                  // print('data: ${items.asMap().toString()}');
                                  // for (var item in items) {
                                  //   print(
                                  //       'menu: ${item.product.name}, quantity: ${item.quantity}');
                                  // }
                                  print(
                                      'total qty: ${orders[index].totalItem}');
                                  print(
                                      'total price: ${orders[index].subTotal}');
                                  print(
                                      'payment methode: ${orders[index].paymentMethod}');
                                  print(
                                      'payment amount: ${orders[index].paymentAmount}');
                                  print(
                                      'total diskon: ${orders[index].discount}');
                                  print('total tax: ${orders[index].tax}');
                                  print('subtotal: ${orders[index].subTotal}');
                                  print(
                                      'normal price: ${orders[index].subTotal}');
                                },
                                label: 'Print',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
                itemCount: orders.length,
                rowSeparatorWidget: const Divider(
                  color: Colors.black38,
                  height: 1.0,
                  thickness: 0.0,
                ),
                leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
                rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
                itemExtent: 55,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
