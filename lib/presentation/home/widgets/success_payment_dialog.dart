// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import 'package:flutter_pos_apps/core/core.dart';
import 'package:flutter_pos_apps/data/datasources/auth_local_remote_datasource.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../data/dataoutputs/print_dataoutputs.dart';
import '../bloc/checkout/checkout_bloc.dart';
import '../bloc/order/order_bloc.dart';
import '../models/product_qty.dart';

class SuccessPaymentDialog extends StatefulWidget {
  const SuccessPaymentDialog({
    Key? key,
    required this.data,
    required this.totalQty,
    required this.totalPrice,
    required this.paymentMethode,
    required this.paymentAmount,
    required this.pembayaranUser,
    required this.totalTax,
    required this.totalDiscount,
    required this.subTotal,
    required this.normalPrice,
  }) : super(key: key);
  final List<ProductQuantity> data;
  final int totalQty;
  final int totalPrice;
  final String paymentMethode;
  final int paymentAmount;
  final int pembayaranUser;
  final int totalTax;
  final int totalDiscount;
  final int subTotal;
  final int normalPrice;

  @override
  State<SuccessPaymentDialog> createState() => _SuccessPaymentDialogState();
}

class _SuccessPaymentDialogState extends State<SuccessPaymentDialog> {
  // List<ProductQuantity> data = [];
  // int totalQty = 0;
  // int totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Assets.icons.success.svg()),
            const SpaceHeight(16.0),
            const Center(
              child: Text(
                'Pembayaran telah sukses dilakukan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SpaceHeight(20.0),
            const Text('METODE BAYAR'),
            const SpaceHeight(5.0),
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                final paymentMethod = state.maybeWhen(
                  orElse: () => '',
                  loaded: (model) => model.paymentMethod,
                );
                return Text(
                  paymentMethod,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
            ),
            const SpaceHeight(10.0),
            const Divider(),
            const SpaceHeight(8.0),
            const Text('TOTAL TAGIHAN'),
            const SpaceHeight(5.0),
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                return Text(
                  widget.totalPrice.currencyFormatRp,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
            ),
            const SpaceHeight(10.0),
            const Divider(),
            const SpaceHeight(8.0),
            const Text('NOMINAL BAYAR'),
            const SpaceHeight(5.0),
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                final paymentAmount = state.maybeWhen(
                  orElse: () => 0,
                  loaded: (model) => model.paymentAmount,
                );
                return Text(
                  paymentAmount.ceil().currencyFormatRp,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
            ),
            const Divider(),
            const SpaceHeight(8.0),
            const Text('KEMBALIAN'),
            const SpaceHeight(5.0),
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                final paymentAmount = state.maybeWhen(
                  orElse: () => 0,
                  loaded: (model) => model.paymentAmount,
                );
                final diff = paymentAmount - widget.totalPrice;
                return Text(
                  diff.ceil().currencyFormatRp,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
            ),
            const SpaceHeight(10.0),
            const Divider(),
            const SpaceHeight(8.0),
            const Text('WAKTU PEMBAYARAN'),
            const SpaceHeight(5.0),
            Text(
              DateFormat('dd MMMM yyyy, HH:mm').format(DateTime.now()),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(20.0),
            Row(
              children: [
                Flexible(
                  child: Button.outlined(
                    onPressed: () {
                      context
                          .read<CheckoutBloc>()
                          .add(const CheckoutEvent.started());
                      context.popToRoot();
                    },
                    label: 'Kembali',
                  ),
                ),
                const SpaceWidth(8.0),
                Flexible(
                  child: Button.filled(
                    onPressed: () async {
                      //get nama kasir from shared preferences
                      final namaKasir =
                          await AuthLocalRemoteDatasource().getAuthData();
                      // final paymentAmount =
                      //     context.read<OrderBloc>().state.maybeWhen(
                      //           orElse: () => 0,
                      //           loaded: (model) => model.paymentAmount,
                      //         );
                      final printValue =
                          await PrintDataoutputs.instance.printOrder(
                        widget.data,
                        widget.totalQty,
                        widget.totalPrice,
                        widget.paymentMethode,
                        widget.paymentAmount,
                        widget.paymentAmount,
                        namaKasir.user!.name!,
                        widget.totalDiscount,
                        widget.totalTax,
                        widget.subTotal,
                        widget.normalPrice,
                      );
                      await PrintBluetoothThermal.writeBytes(printValue);
                    },
                    label: 'Print',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
