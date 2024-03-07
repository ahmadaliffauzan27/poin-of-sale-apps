import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_apps/core/extensions/date_time_ext.dart';

import '../../../core/components/custom_date_picker.dart';
import '../../../core/components/dashed_line.dart';
import '../../../core/components/spaces.dart';
import '../widgets/report_menu.dart';
import '../widgets/report_title.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  int selectedMenu = 0;
  String title = 'Summary Sales Report';
  DateTime fromDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime toDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
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
                            label: 'Transaction Report',
                            onPressed: () {
                              selectedMenu = 1;
                              title = 'Transaction Report';
                              setState(() {});
                              //enddate is 1 month before the current date
                              // context.read<TransactionReportBloc>().add(
                              //     TransactionReportEvent.getReport(
                              //         startDate: DateTime.now(),
                              //         endDate: DateTime.now()
                              //             .subtract(const Duration(days: 30))));
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
          // Expanded(
          //   flex: 2,
          //   child: Align(
          //     alignment: Alignment.topCenter,
          //     child: SingleChildScrollView(
          //       padding: const EdgeInsets.all(24.0),
          //       child:
          //           BlocBuilder<TransactionReportBloc, TransactionReportState>(
          //         builder: (context, state) {
          //           final totalRevenue = state.maybeMap(
          //             orElse: () => 0,
          //             loaded: (value) {
          //               return value.transactionReport.fold(
          //                 0,
          //                 (previousValue, element) =>
          //                     previousValue + element.total,
          //               );
          //             },
          //           );

          //           final subTotal = state.maybeMap(
          //             orElse: () => 0,
          //             loaded: (value) {
          //               return value.transactionReport.fold(
          //                 0,
          //                 (previousValue, element) =>
          //                     previousValue + element.subTotal,
          //               );
          //             },
          //           );

          //           final discount = state.maybeMap(
          //             orElse: () => 0,
          //             loaded: (value) {
          //               return value.transactionReport.fold(
          //                 0,
          //                 (previousValue, element) =>
          //                     previousValue + element.discount,
          //               );
          //             },
          //           );

          //           final tax = state.maybeMap(
          //             orElse: () => 0,
          //             loaded: (value) {
          //               return value.transactionReport.fold(
          //                 0,
          //                 (previousValue, element) =>
          //                     previousValue + element.tax,
          //               );
          //             },
          //           );
          //           return state.maybeWhen(orElse: () {
          //             return const Center(
          //               child: Text('No Data'),
          //             );
          //           }, loading: () {
          //             return const Center(
          //               child: CircularProgressIndicator(),
          //             );
          //           }, loaded: (transactionReport) {
          //             return Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Center(
          //                   child: Text(
          //                     title,
          //                     style: const TextStyle(
          //                         fontWeight: FontWeight.w600, fontSize: 16.0),
          //                   ),
          //                 ),
          //                 Center(
          //                   child: Text(
          //                     searchDateFormatted,
          //                     style: const TextStyle(fontSize: 16.0),
          //                   ),
          //                 ),
          //                 const SpaceHeight(16.0),

          //                 // REVENUE INFO
          //                 ...[
          //                   Text('REVENUE : $totalRevenue'),
          //                   const SpaceHeight(8.0),
          //                   const DashedLine(),
          //                   const DashedLine(),
          //                   const SpaceHeight(8.0),
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       Text('Subtotal'),
          //                       Text('$subTotal'),
          //                     ],
          //                   ),
          //                   const SpaceHeight(4.0),
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       Text('Discount'),
          //                       Text('$discount'),
          //                     ],
          //                   ),
          //                   const SpaceHeight(4.0),
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       Text('Tax'),
          //                       Text('$tax'),
          //                     ],
          //                   ),
          //                   const SpaceHeight(8.0),
          //                   const DashedLine(),
          //                   const DashedLine(),
          //                   const SpaceHeight(8.0),
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       Text('TOTAL'),
          //                       Text('$totalRevenue'),
          //                     ],
          //                   ),
          //                 ],
          //                 const SpaceHeight(32.0),

          //                 // PAYMENT INFO
          //                 // ...[
          //                 //   const Text('PAYMENT'),
          //                 //   const SpaceHeight(8.0),
          //                 //   const DashedLine(),
          //                 //   const DashedLine(),
          //                 //   const SpaceHeight(8.0),
          //                 //   const Row(
          //                 //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 //     children: [
          //                 //       Text('Cash'),
          //                 //       Text('0'),
          //                 //     ],
          //                 //   ),
          //                 //   const SpaceHeight(8.0),
          //                 //   const DashedLine(),
          //                 //   const DashedLine(),
          //                 //   const SpaceHeight(8.0),
          //                 //   const Row(
          //                 //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 //     children: [
          //                 //       Text('TOTAL'),
          //                 //       Text('0'),
          //                 //     ],
          //                 //   ),
          //                 // ],
          //               ],
          //             );
          //           });
          //         },
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
