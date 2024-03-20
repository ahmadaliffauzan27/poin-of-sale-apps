import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pos_apps/core/core.dart';
import 'package:flutter_pos_apps/core/extensions/date_time_ext.dart';
import 'package:flutter_pos_apps/core/extensions/int_ext.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../core/extensions/helper_pdf_service.dart';
import '../../../core/extensions/permission.dart';
import '../../../data/models/response/order_response_model.dart';
import '../utils/transaction_invoice.dart';

class TransactionReportWidget extends StatelessWidget {
  final String title;
  final String searchDateFormatted;
  final List<ItemOrder> transactionReport;
  final List<Widget>? headerWidgets;
  const TransactionReportWidget({
    super.key,
    required this.transactionReport,
    required this.title,
    required this.searchDateFormatted,
    required this.headerWidgets,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          const SpaceHeight(24.0),
          Center(
            child: Text(
              title,
              style:
                  const TextStyle(fontWeight: FontWeight.w800, fontSize: 16.0),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  searchDateFormatted,
                  style: const TextStyle(fontSize: 16.0),
                ),
                // GestureDetector(
                //   onTap: () async {
                //     final status = await PermissionHelper().checkPermission();
                //     if (status.isGranted) {
                //       final pdfFile = await TransactionSalesInvoice.generate(
                //           transactionReport, searchDateFormatted);
                //       log("pdfFile: $pdfFile");
                //       HelperPdfService.openFile(pdfFile);
                //     }
                //   },
                //   child: const Row(
                //     children: [
                //       Text(
                //         "PDF",
                //         style: TextStyle(
                //           fontSize: 14.0,
                //           fontWeight: FontWeight.bold,
                //           color: AppColors.primary,
                //         ),
                //       ),
                //       Icon(
                //         Icons.download_outlined,
                //         color: AppColors.primary,
                //       )
                //     ],
                //   ),
                // ),
                GestureDetector(
                  onTap: () async {
                    final status = await PermissionHelper().checkPermission();
                    if (status.isGranted) {
                      try {
                        final pdfFile = await TransactionSalesInvoice.generate(
                            transactionReport, searchDateFormatted);
                        log("pdfFile: $pdfFile");

                        // Konversi File menjadi Document
                        final pdfDocument =
                            await HelperPdfService.convertFileToPdfDocument(
                                pdfFile);

                        // Simpan PDF ke penyimpanan perangkat
                        final savedFile = await HelperPdfService.saveDocument(
                          name: 'laporan.pdf',
                          pdf: pdfDocument,
                        );

                        // Buka file PDF yang telah disimpan
                        await HelperPdfService.openFile(savedFile);
                      } catch (e) {
                        log("Failed to generate or open PDF: $e");
                      }
                    }
                  },
                  child: const Row(
                    children: [
                      Text(
                        "PDF",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      Icon(
                        Icons.download_outlined,
                        color: AppColors.primary,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SpaceHeight(16.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: HorizontalDataTable(
                  leftHandSideColumnWidth: 50,
                  rightHandSideColumnWidth: 850,
                  isFixedHeader: true,
                  headerWidgets: headerWidgets,
                  // isFixedFooter: true,
                  // footerWidgets: _getTitleWidget(),
                  leftSideItemBuilder: (context, index) {
                    return Container(
                      width: 40,
                      height: 52,
                      alignment: Alignment.centerLeft,
                      child: Center(
                          child: Text(transactionReport[index].id.toString())),
                    );
                  },
                  rightSideItemBuilder: (context, index) {
                    return Row(
                      children: <Widget>[
                        Container(
                          width: 120,
                          height: 52,
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Center(
                              child: Text(
                            transactionReport[index].total!.currencyFormatRp,
                          )),
                        ),
                        Container(
                          width: 120,
                          height: 52,
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            transactionReport[index].subTotal!.currencyFormatRp,
                          ),
                        ),
                        // Container(
                        //   width: 100,
                        //   height: 52,
                        //   padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        //   alignment: Alignment.centerLeft,
                        //   child: Center(
                        //       child: Text(
                        //     transactionReport[index].tax!.currencyFormatRp,
                        //   )),
                        // ),
                        Container(
                          width: 100,
                          height: 52,
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            // Mengubah persentase diskon menjadi nominal dan memformatnya ke dalam format mata uang yang diinginkan
                            (transactionReport[index].discount! *
                                    transactionReport[index].total! /
                                    100)
                                .toString()
                                .toIntegerFromText
                                .currencyFormatRp
                                .replaceAll('.0',
                                    ''), // Menyertakan 2 angka di belakang koma
                          ),
                        ),
                        // Container(
                        //   width: 100,
                        //   height: 52,
                        //   padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        //   alignment: Alignment.centerLeft,
                        //   child: Center(
                        //     child: Text(
                        //       transactionReport[index]
                        //           .serviceCharge!
                        //           .currencyFormatRp,
                        //     ),
                        //   ),
                        // ),
                        Container(
                          width: 100,
                          height: 52,
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                              transactionReport[index].totalItem.toString()),
                        ),
                        Container(
                          width: 150,
                          height: 52,
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(transactionReport[index].namaKasir!),
                        ),
                        Container(
                          width: 230,
                          height: 52,
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child:
                              Text(transactionReport[index].transactionTime!),
                        ),
                      ],
                    );
                  },
                  itemCount: transactionReport.length,
                  rowSeparatorWidget: const Divider(
                    color: Colors.black38,
                    height: 1.0,
                    thickness: 0.0,
                  ),
                  leftHandSideColBackgroundColor: AppColors.white,
                  rightHandSideColBackgroundColor: AppColors.white,

                  itemExtent: 55,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
