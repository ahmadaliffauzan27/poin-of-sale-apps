import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_apps/core/core.dart';
import 'package:flutter_pos_apps/presentation/history/history/bloc/history_bloc_bloc.dart';
import 'package:flutter_pos_apps/presentation/history/widgets/history_widget.dart';

import '../../../core/constants/colors.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    context.read<HistoryBlocBloc>().add(const HistoryBlocEvent.loadHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'History Penjualan',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                DateTime.now().toFormattedDate(),
                style: const TextStyle(
                  color: AppColors.subtitle,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          Expanded(
            child: BlocBuilder<HistoryBlocBloc, HistoryBlocState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  loaded: (orders) {
                    log("message: ${orders.length}");
                    if (orders.isEmpty) {
                      return const Center(
                        child: Text(
                          "Belum ada transaksi baru.",
                          style: TextStyle(
                            fontSize: 16.0,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else {
                      return HistoryWidget(
                        headerWidgets: _getTitleHeaderWidget(),
                        orders: orders,
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getTitleHeaderWidget() {
    return [
      _getTitleItemWidget('ID', 50),
      _getTitleItemWidget('Pembayaran', 130),
      _getTitleItemWidget('Subtotal', 100),
      _getTitleItemWidget('Pajak', 130),
      _getTitleItemWidget('Diskon', 50),
      // _getTitleItemWidget('Discount Amount', 120),
      // _getTitleItemWidget('Service Charge', 120),
      _getTitleItemWidget('Total Harga', 120),
      _getTitleItemWidget('Metode', 80),
      _getTitleItemWidget('Jumlah', 60),
      _getTitleItemWidget('Nama Kasir', 150),
      _getTitleItemWidget('Waktu Penjualan', 230),
      // _getTitleItemWidget('Action', 230),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      color: AppColors.primary,
      alignment: Alignment.centerLeft,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
