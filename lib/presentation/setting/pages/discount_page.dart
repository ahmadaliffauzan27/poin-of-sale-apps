import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_apps/presentation/setting/bloc/tax/tax_bloc.dart';
import 'package:flutter_pos_apps/presentation/setting/dialogs/form_discount_dialog_tax.dart';
import 'package:flutter_pos_apps/presentation/setting/widgets/manage_tax_card.dart';

import '../../../data/models/response/discount_response_model.dart';
import '../../../data/models/response/tax_response_model.dart';
import '../../home/widgets/custom_tab_bar.dart';
import '../bloc/discount/discount_bloc.dart';
import '../dialogs/form_discount_dialog.dart';
import '../models/discount_model.dart';
import '../widgets/add_data.dart';
import '../widgets/manage_discount_card.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  // final List<DiscountModel> discounts = [
  //   DiscountModel(
  //     name: '20',
  //     code: 'BUKAPUASA',
  //     description: null,
  //     discount: 50,
  //     category: ProductCategory.food,
  //   ),
  // ];

  void onEditTax(Tax item) {
    showDialog(
      context: context,
      builder: (context) => FormDiscountDialogTax(data: item),
    );
  }

  void onAddDataTax() {
    showDialog(
      context: context,
      builder: (context) => const FormDiscountDialogTax(),
    );
  }

  void onEditTap(Discount item) {
    showDialog(
      context: context,
      builder: (context) => FormDiscountDialog(data: item),
    );
  }

  void onAddDataTap() {
    showDialog(
      context: context,
      builder: (context) => const FormDiscountDialog(),
    );
  }

  @override
  void initState() {
    context.read<DiscountBloc>().add(const DiscountEvent.getDiscounts());
    context.read<TaxBloc>().add(const TaxEvent.getTaxs());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<DiscountBloc>().add(const DiscountEvent.getDiscounts());
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            CustomTabBar(
              tabTitles: const ['Diskon', 'Pajak'],
              initialTabIndex: 0,
              tabViews: [
                // Tab Diskon
                SizedBox(
                  child: BlocBuilder<DiscountBloc, DiscountState>(
                    builder: (context, state) {
                      return state.maybeWhen(orElse: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }, loaded: (discounts) {
                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: discounts.length + 1,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.85,
                            crossAxisCount: 3,
                            crossAxisSpacing: 30.0,
                            mainAxisSpacing: 30.0,
                          ),
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return AddData(
                                title: 'Tambah Diskon Baru',
                                onPressed: onAddDataTap,
                              );
                            }
                            final item = discounts[index - 1];
                            return ManageDiscountCard(
                              data: item,
                              onEditTap: () {
                                onEditTap(item);
                              },
                            );
                          },
                        );
                      });
                    },
                  ),
                ),

//Tab pajak
                SizedBox(
                  child: BlocBuilder<TaxBloc, TaxState>(
                    builder: (context, state) {
                      return state.maybeWhen(orElse: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }, loaded: (tax) {
                        return GridView.builder(
                          shrinkWrap: true,
                          itemCount: tax.length + 1,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.85,
                            crossAxisCount: 3,
                            crossAxisSpacing: 30.0,
                            mainAxisSpacing: 30.0,
                          ),
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return AddData(
                                title: 'Tambah Pajak Baru',
                                onPressed: onAddDataTax,
                              );
                            }
                            final item = tax[index - 1];
                            return ManageTaxCard(
                              data: item,
                              onEditTap: () {
                                onEditTax(item);
                              },
                            );
                          },
                        );
                      });
                    },
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
