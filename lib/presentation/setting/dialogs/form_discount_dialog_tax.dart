import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_apps/core/core.dart';
import 'package:flutter_pos_apps/presentation/setting/bloc/add_tax/add_tax_bloc.dart';
import 'package:flutter_pos_apps/presentation/setting/bloc/delete_discount/delete_discount_bloc.dart';
import 'package:flutter_pos_apps/presentation/setting/bloc/delete_tax/delete_tax_bloc.dart';
import 'package:flutter_pos_apps/presentation/setting/bloc/edit_discount/edit_discount_bloc.dart';
import 'package:flutter_pos_apps/presentation/setting/bloc/edit_tax/edit_tax_bloc.dart';
import 'package:flutter_pos_apps/presentation/setting/bloc/tax/tax_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../../../data/models/response/discount_response_model.dart';
import '../../../data/models/response/tax_response_model.dart';
import '../bloc/add_discount/add_discount_bloc.dart';
import '../bloc/discount/discount_bloc.dart';
import '../models/discount_model.dart';

class FormDiscountDialogTax extends StatefulWidget {
  final Tax? data;
  const FormDiscountDialogTax({super.key, this.data});

  @override
  State<FormDiscountDialogTax> createState() => _FormDiscountDialogTaxState();
}

class _FormDiscountDialogTaxState extends State<FormDiscountDialogTax> {
  @override
  void initState() {
    // context.read<DiscountBloc>().add(const DiscountEvent.getDiscounts());

    taxController.text = widget.data?.value?.replaceAll('.00', '') ?? '';
    super.initState();
  }

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final taxController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.close),
          ),
          widget.data == null
              ? const Text('Tambah Pajak')
              : const Text('Edit Pajak'),
          const Spacer(),
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 200,
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SpaceHeight(24.0),
              Flexible(
                child: CustomTextField(
                  showLabel: false,
                  controller: taxController,
                  label: 'Pajak',
                  prefixIcon: const Icon(Icons.percent),
                  onChanged: (value) {},
                  keyboardType: TextInputType.number,
                ),
              ),
              const SpaceHeight(24.0),
              widget.data == null
                  ? BlocConsumer<TaxBloc, TaxState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          loaded: (tax) {
                            context
                                .read<TaxBloc>()
                                .add(const TaxEvent.getTaxs());
                          },
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(orElse: () {
                          return Button.filled(
                            onPressed: () {
                              context.read<AddTaxBloc>().add(
                                    AddTaxEvent.addDiscount(
                                      value: int.parse(taxController.text),
                                    ),
                                  );
                              context
                                  .read<TaxBloc>()
                                  .add(const TaxEvent.getTaxs());
                              context.pop();
                            },
                            label: 'Simpan Pajak',
                          );
                        }, loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                      },
                    )
                  : BlocConsumer<EditTaxBloc, EditTaxState>(
                      listener: (context, state) {
                        state.maybeWhen(
                            orElse: () {},
                            success: () {
                              context
                                  .read<TaxBloc>()
                                  .add(const TaxEvent.getTaxs());
                            });
                      },
                      builder: (context, state) {
                        return state.maybeWhen(orElse: () {
                          return Button.filled(
                            onPressed: () {
                              context.read<EditTaxBloc>().add(
                                  EditTaxEvent.editTax(
                                      id: widget.data!.id.toString(),
                                      value: int.parse(taxController.text)
                                          .toDouble()));
                              context
                                  .read<TaxBloc>()
                                  .add(const TaxEvent.getTaxs());
                              context.pop();
                            },
                            label: 'Simpan Pajak',
                          );
                        }, loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                      },
                    ),
              const SpaceHeight(24),
              widget.data != null
                  ? BlocConsumer<DeleteTaxBloc, DeleteTaxState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          loaded: () {
                            context
                                .read<TaxBloc>()
                                .add(const TaxEvent.getTaxs());
                            context.pop();
                          },
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(orElse: () {
                          return Button.filled(
                            onPressed: () {
                              context.read<DeleteTaxBloc>().add(
                                    DeleteTaxEvent.deleteTax(
                                      widget.data!.id.toString(),
                                    ),
                                  );
                            },
                            label: 'Hapus Pajak',
                            color: AppColors.red,
                          );
                        }, loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                      },
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
