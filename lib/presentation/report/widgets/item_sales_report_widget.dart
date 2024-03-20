import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pos_apps/core/extensions/int_ext.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../core/extensions/helper_pdf_service.dart';
import '../../../core/extensions/permission.dart';
import '../../../data/models/response/item_sales_model.dart';
import '../utils/item_sales_invoice.dart';

class ItemSalesReportWidget extends StatelessWidget {
  final String title;
  final String searchDateFormatted;
  final List<ItemSales> itemSales;
  final List<Widget>? headerWidgets;

  const ItemSalesReportWidget({
    Key? key,
    required this.itemSales,
    required this.title,
    required this.searchDateFormatted,
    required this.headerWidgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Map untuk melacak warna untuk setiap orderId
    Map<int, Color> orderIdColors = {};
    // Map untuk melacak warna untuk setiap id
    Map<int, Color> idColors = {};

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
                GestureDetector(
                  onTap: () async {
                    final status = await PermissionHelper().checkPermission();
                    if (status.isGranted) {
                      final pdfFile = await ItemSalesInvoice.generate(
                          itemSales, searchDateFormatted);
                      log("pdfFile: $pdfFile");
                      HelperPdfService.openFile(pdfFile);
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
                  leftHandSideColumnWidth: 80,
                  rightHandSideColumnWidth: 560,
                  isFixedHeader: true,
                  headerWidgets: headerWidgets,
                  leftSideItemBuilder: (context, index) {
                    final orderId = itemSales[index].orderId;
                    final color = orderIdColors.putIfAbsent(orderId!, () {
                      int count = orderIdColors.length;
                      return count % 2 == 0 ? Colors.white : Colors.grey[300]!;
                    });

                    if (index == 0 ||
                        itemSales[index].orderId !=
                            itemSales[index - 1].orderId) {
                      return Container(
                        width: 80,
                        height: 52,
                        alignment: Alignment.centerLeft,
                        color: color,
                        child: Center(child: Text(orderId.toString())),
                      );
                    } else {
                      return Container(
                        width: 80,
                        height: 52,
                        color: color,
                      );
                    }
                  },
                  rightSideItemBuilder: (context, index) {
                    final orderId = itemSales[index].orderId;
                    final color = orderIdColors[orderId];
                    // final id = itemSales[index].id;
                    // final idColor = idColors.putIfAbsent(id!, () => color!);

                    return Row(
                      children: <Widget>[
                        Container(
                          width: 160,
                          height: 52,
                          alignment: Alignment.centerLeft,
                          color: color,
                          child: Text(itemSales[index].productName!),
                        ),
                        Container(
                          width: 60,
                          height: 52,
                          alignment: Alignment.centerLeft,
                          color: color,
                          child: Center(
                              child:
                                  Text(itemSales[index].quantity.toString())),
                        ),
                        Container(
                          width: 140,
                          height: 52,
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          color: color,
                          child: Center(
                            child: Text(
                              itemSales[index].price!.currencyFormatRp,
                            ),
                          ),
                        ),
                        Container(
                          width: 140,
                          height: 52,
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          color: color,
                          child: Center(
                            child: Text(
                              (itemSales[index].price! *
                                      itemSales[index].quantity!)
                                  .currencyFormatRp,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: itemSales.length,
                  rowSeparatorWidget: const Divider(
                    color: Colors.black38,
                    height: 1.0,
                    thickness: 0.0,
                  ),
                  leftHandSideColBackgroundColor: Colors.white,
                  rightHandSideColBackgroundColor: Colors.white,
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
