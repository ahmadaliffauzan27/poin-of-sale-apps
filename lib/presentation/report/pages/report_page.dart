import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_apps/core/core.dart';

import '../../../core/components/custom_date_picker.dart';
import '../../../core/components/dashed_line.dart';
import '../../../core/components/spaces.dart';
import '../bloc/transaction_report/transaction_report_bloc.dart';
import '../widgets/report_menu.dart';
import '../widgets/report_title.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  int selectedMenu = 0;
  String title = 'All Transaction Report';
  DateTime fromDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime toDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String searchDateFormatted =
        '${fromDate.toFormattedDate2()} to ${toDate.toFormattedDate2()}';
    return Scaffold(
      body: Row(
        children: [
          // LEFT CONTENT
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ReportTitle(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
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
                          const SpaceWidth(100.0),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Wrap(
                        children: [
                          ReportMenu(
                            label: 'All Transaction Report',
                            onPressed: () {
                              selectedMenu = 1;
                              title = 'All Transaction Report';
                              setState(() {});
                              //enddate is 1 month before the current date
                              context.read<TransactionReportBloc>().add(
                                  TransactionReportEvent.getReportData(
                                      startDate: DateTime.now(),
                                      endDate: DateTime.now()
                                          .subtract(const Duration(days: 30))));
                            },
                            isActive: selectedMenu == 1,
                          ),
                          ReportMenu(
                            label: 'Item Sales Report',
                            onPressed: () {
                              selectedMenu = 4;
                              title = 'Item Sales Report';
                              setState(() {});
                            },
                            isActive: selectedMenu == 4,
                          ),
                          ReportMenu(
                            label: 'Daily Sales Report',
                            onPressed: () {
                              selectedMenu = 5;
                              title = 'Daily Sales Report';
                              setState(() {});
                            },
                            isActive: selectedMenu == 5,
                          ),
                          ReportMenu(
                            label: 'Summary Sales Report',
                            onPressed: () {
                              selectedMenu = 0;
                              title = 'Summary Sales Report';
                              setState(() {});
                            },
                            isActive: selectedMenu == 0,
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
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child:
                    BlocBuilder<TransactionReportBloc, TransactionReportState>(
                  builder: (context, state) {
                    final totalRevenue = state.maybeMap(
                      orElse: () => 0,
                      loaded: (value) {
                        return value.data.fold(
                          0,
                          (previousValue, element) =>
                              previousValue + element.total,
                        );
                      },
                    );

                    final subTotal = state.maybeMap(
                      orElse: () => 0,
                      loaded: (value) {
                        return value.data.fold(
                          0,
                          (previousValue, element) =>
                              previousValue + element.subTotal,
                        );
                      },
                    );

                    // ignore: unused_local_variable
                    final discount = state.maybeMap(
                      orElse: () => 0,
                      loaded: (value) {
                        return value.data.fold(
                          0,
                          (previousValue, element) => (previousValue +
                                  element.discount / 100 * subTotal)
                              .toInt(),
                        );
                      },
                    );

                    // final discount = discountPercentage / 100 * subTotal;

                    final tax = state.maybeMap(
                      orElse: () => 0,
                      loaded: (value) {
                        return value.data.fold(
                          0,
                          (previousValue, element) =>
                              previousValue + element.tax,
                        );
                      },
                    );
                    return state.maybeWhen(orElse: () {
                      return const Center(
                        heightFactor: 30,
                        child: Text('No Data'),
                      );
                    }, loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }, loaded: (transactionReport) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Center(
                              child: Text(
                                title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                          const SpaceHeight(16.0),

                          Center(
                            child: Text(
                              searchDateFormatted,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ),
                          const SpaceHeight(16.0),

                          // REVENUE INFO
                          ...[
                            Text('REVENUE : ${totalRevenue.currencyFormatRp}'),
                            const SpaceHeight(8.0),
                            const DashedLine(),
                            const DashedLine(),
                            const SpaceHeight(8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Subtotal'),
                                Text('$subTotal'
                                    .toIntegerFromText
                                    .currencyFormatRp),
                              ],
                            ),
                            const SpaceHeight(4.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Discount'),
                                Text('$discount'
                                    .toIntegerFromText
                                    .currencyFormatRp),
                              ],
                            ),
                            const SpaceHeight(4.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Tax'),
                                Text('$tax'.toIntegerFromText.currencyFormatRp),
                              ],
                            ),
                            const SpaceHeight(8.0),
                            const DashedLine(),
                            const DashedLine(),
                            const SpaceHeight(8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('TOTAL'),
                                Text('$totalRevenue'
                                    .toIntegerFromText
                                    .currencyFormatRp),
                              ],
                            ),
                          ],
                          const SpaceHeight(32.0),

                          // PAYMENT INFO
                          // ...[
                          //   const Text('PAYMENT'),
                          //   const SpaceHeight(8.0),
                          //   const DashedLine(),
                          //   const DashedLine(),
                          //   const SpaceHeight(8.0),
                          //   const Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text('Cash'),
                          //       Text('0'),
                          //     ],
                          //   ),
                          //   const SpaceHeight(8.0),
                          //   const DashedLine(),
                          //   const DashedLine(),
                          //   const SpaceHeight(8.0),
                          //   const Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text('TOTAL'),
                          //       Text('0'),
                          //     ],
                          //   ),
                          // ],
                        ],
                      );
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
