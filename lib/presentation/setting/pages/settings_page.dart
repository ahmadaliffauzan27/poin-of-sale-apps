import 'package:flutter/material.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import 'discount_page.dart';
import 'manage_printer_page.dart';
import 'sync_data_pages.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int currentIndex = 0;

  void indexValue(int index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // LEFT CONTENT
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SpaceHeight(16.0),
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    // ignore: deprecated_member_use_from_same_package
                    leading:
                        // ignore: deprecated_member_use_from_same_package
                        Assets.icons.kelolaDiskon.svg(color: AppColors.primary),
                    title: const Text('Kelola Biaya'),
                    subtitle: const Text('Kelola Diskon dan Pajak'),
                    textColor: AppColors.primary,
                    tileColor: currentIndex == 0
                        ? AppColors.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(0),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    // ignore: deprecated_member_use_from_same_package
                    leading: Assets.icons.kelolaPrinter
                        // ignore: deprecated_member_use_from_same_package
                        .svg(color: AppColors.primary),
                    title: const Text('Kelola Printer'),
                    subtitle: const Text('Tambah atau hapus printer'),
                    textColor: AppColors.primary,
                    tileColor: currentIndex == 1
                        ? AppColors.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(1),
                  ),
                  // ListTile(
                  //   contentPadding: const EdgeInsets.all(12.0),
                  //   // ignore: deprecated_member_use_from_same_package
                  //   leading:
                  //       // ignore: deprecated_member_use_from_same_package
                  //       Assets.icons.kelolaPajak.svg(color: AppColors.primary),
                  //   title: const Text('Perhitungan Biaya'),
                  //   subtitle: const Text('Kelola biaya diluar biaya modal'),
                  //   textColor: AppColors.primary,
                  //   tileColor: currentIndex == 2
                  //       ? AppColors.blueLight
                  //       : Colors.transparent,
                  //   onTap: () => indexValue(2),
                  // ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    // ignore: deprecated_member_use_from_same_package
                    leading:
                        // ignore: deprecated_member_use_from_same_package
                        Assets.icons.kelolaPajak.svg(color: AppColors.primary),
                    title: const Text('Sync Data'),
                    subtitle: const Text('Sync data ke server atau sebaliknya'),
                    textColor: AppColors.primary,
                    tileColor: currentIndex == 2
                        ? AppColors.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(2),
                  ),
                ],
              ),
            ),
          ),

          // RIGHT CONTENT
          Expanded(
            flex: 4,
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IndexedStack(
                  index: currentIndex,
                  children: const [
                    DiscountPage(),
                    ManagePrinterPage(),
                    // TaxPage(),
                    SyncDataPage(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
