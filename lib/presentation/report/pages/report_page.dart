import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_apps/core/components/loading.dart';
import 'package:flutter_pos_apps/core/extensions/date_time_ext.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import '../../../core/components/custom_date_picker.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../core/extensions/date_formatter.dart';
import '../bloc/item_sales/item_sales_bloc.dart';
import '../bloc/product_sales/product_sales_bloc.dart';
import '../bloc/summary_reports/summary_reports_bloc.dart';
import '../bloc/transaction_report/transaction_report_bloc.dart';
import '../widgets/item_sales_report_widget.dart';
import '../widgets/product_sales_chart_widget.dart';
import '../widgets/report_menu.dart';
import '../widgets/report_title.dart';
import '../widgets/summary_report_widget.dart';
import '../widgets/transaction_report_widget.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  int selectedMenu = 0;
  String title = 'Summary Sales Report';
  // DateTime fromDate = DateTime.now().subtract(const Duration(days: 30));
  // DateTime toDate = DateTime.now();

  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    super.initState();

    setState(() {
      selectedMenu = 0;
    });
    // Inisialisasi zona waktu
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

    // Mendapatkan tanggal saat ini di Jakarta
    DateTime nowInJakarta = DateTime.now();

    // Menghitung tanggal 30 hari yang lalu
    fromDate = nowInJakarta.subtract(const Duration(days: 30));
    toDate = nowInJakarta;

    // print('DateTime.now() di initState: ${DateTime.now()}');
  }

  @override
  Widget build(BuildContext context) {
    String searchDateFormatted =
        '${fromDate.toFormattedDate2()} to ${toDate.toFormattedDate2()}';
    return Scaffold(
      body: Row(
        children: [
          // LEFT CONTENT
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ReportTitle(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: CustomDatePicker(
                            prefix: const Text('From: '),
                            initialDate: fromDate,
                            onDateSelected: (selectedDate) {
                              fromDate = selectedDate;

                              setState(() {});
                            },
                          ),
                        ),
                        const SpaceWidth(24.0),
                        Flexible(
                          child: CustomDatePicker(
                            prefix: const Text('To: '),
                            initialDate: toDate,
                            onDateSelected: (selectedDate) {
                              toDate = selectedDate;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Wrap(
                        children: [
                          ReportMenu(
                            label: 'Transaction Report',
                            onPressed: () {
                              selectedMenu = 0;
                              title = 'Transaction Report';
                              setState(() {});
                              //enddate is 1 month before the current date
                              context.read<TransactionReportBloc>().add(
                                    TransactionReportEvent.getReportData(
                                        startDate: DateFormatter.formatDateTime(
                                            fromDate),
                                        endDate: DateFormatter.formatDateTime(
                                            toDate)),
                                  );
                            },
                            isActive: selectedMenu == 0,
                          ),
                          ReportMenu(
                            label: 'Item Sales Report',
                            onPressed: () {
                              selectedMenu = 1;
                              title = 'Item Sales Report';
                              setState(() {});
                              context.read<ItemSalesBloc>().add(
                                    ItemSalesEvent.getItemSales(
                                        startDate: DateFormatter.formatDateTime(
                                            fromDate),
                                        endDate: DateFormatter.formatDateTime(
                                            toDate)),
                                  );
                            },
                            isActive: selectedMenu == 1,
                          ),
                          ReportMenu(
                            label: 'Product Sales Chart',
                            onPressed: () {
                              selectedMenu = 2;
                              title = 'Product Sales Chart';
                              setState(() {});
                              context.read<ProductSalesBloc>().add(
                                    ProductSalesEvent.getProductSales(
                                        startDate: DateFormatter.formatDateTime(
                                            fromDate),
                                        endDate: DateFormatter.formatDateTime(
                                            toDate)),
                                  );
                            },
                            isActive: selectedMenu == 2,
                          ),
                          ReportMenu(
                            label: 'Summary Sales Report',
                            onPressed: () {
                              selectedMenu = 3;
                              title = 'Summary Sales Report';
                              setState(() {});

                              context.read<SummaryReportBloc>().add(
                                    SummaryReportsEvent.getSummaryReports(
                                        startDate: DateFormatter.formatDateTime(
                                            fromDate),
                                        endDate: DateFormatter.formatDateTime(
                                            toDate)),
                                  );
                            },
                            isActive: selectedMenu == 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // RIGHT CONTENT
          Expanded(
              flex: 2,
              child: selectedMenu == 0
                  ? BlocBuilder<TransactionReportBloc, TransactionReportState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () => const Center(
                            child: LoadingIcon(),
                          ),
                          error: (message) {
                            return Text(message);
                          },
                          loaded: (transactionReport) {
                            return TransactionReportWidget(
                              transactionReport: transactionReport,
                              title: title,
                              searchDateFormatted: searchDateFormatted,
                              headerWidgets: _getTitleReportPageWidget(),
                            );
                          },
                        );
                      },
                    )
                  : selectedMenu == 1
                      ? BlocBuilder<ItemSalesBloc, ItemSalesState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () => const Center(
                                child: LoadingIcon(),
                              ),
                              error: (message) {
                                return Text(message);
                              },
                              loaded: (itemSales) {
                                return ItemSalesReportWidget(
                                  itemSales: itemSales,
                                  title: title,
                                  searchDateFormatted: searchDateFormatted,
                                  headerWidgets: _getItemSalesPageWidget(),
                                );
                              },
                            );
                          },
                        )
                      : selectedMenu == 2
                          ? BlocBuilder<ProductSalesBloc, ProductSalesState>(
                              builder: (context, state) {
                                return state.maybeWhen(
                                  orElse: () => const Center(
                                    child: LoadingIcon(),
                                  ),
                                  error: (message) {
                                    return Text(message);
                                  },
                                  loaded: (productSales) {
                                    return ProductSalesChartWidgets(
                                      title: title,
                                      searchDateFormatted: searchDateFormatted,
                                      productSales: productSales,
                                    );
                                  },
                                );
                              },
                            )
                          : BlocBuilder<SummaryReportBloc, SummaryReportsState>(
                              builder: (context, state) {
                                return state.maybeWhen(
                                  orElse: () => const Center(
                                    child: LoadingIcon(),
                                  ),
                                  error: (message) {
                                    return Text(message);
                                  },
                                  loaded: (summary) {
                                    return SummaryReportWidget(
                                      summary: summary,
                                      title: title,
                                      searchDateFormatted: searchDateFormatted,
                                    );
                                  },
                                );
                              },
                            )),
        ],
      ),
    );
  }

  List<Widget> _getTitleReportPageWidget() {
    return [
      _getTitleItemWidget('ID', 120),
      _getTitleItemWidget('Total', 100),
      // _getTitleItemWidget('Sub Total', 100),
      // _getTitleItemWidget('Tax', 100),
      // _getTitleItemWidget('Discount', 100),
      // _getTitleItemWidget('Service', 100),
      _getTitleItemWidget('Total Item', 100),
      _getTitleItemWidget('Cashier', 180),
      _getTitleItemWidget('Time', 200),
    ];
  }

  List<Widget> _getItemSalesPageWidget() {
    return [
      _getTitleItemWidget('ID', 80),
      // _getTitleItemWidget('Order', 60),
      _getTitleItemWidget('Product', 160),
      _getTitleItemWidget('Qty', 60),
      _getTitleItemWidget('Price', 280),
      // _getTitleItemWidget('Total Price', 140),
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
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
