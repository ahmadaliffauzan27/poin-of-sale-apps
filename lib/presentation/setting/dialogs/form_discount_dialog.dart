import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_apps/core/core.dart';
import 'package:flutter_pos_apps/presentation/setting/bloc/edit_discount/edit_discount_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../../../data/models/response/discount_response_model.dart';
import '../bloc/add_discount/add_discount_bloc.dart';
import '../bloc/discount/discount_bloc.dart';
import '../models/discount_model.dart';

class FormDiscountDialog extends StatefulWidget {
  final Discount? data;
  const FormDiscountDialog({super.key, this.data});

  @override
  State<FormDiscountDialog> createState() => _FormDiscountDialogState();
}

class _FormDiscountDialogState extends State<FormDiscountDialog> {
  @override
  void initState() {
    // context.read<DiscountBloc>().add(const DiscountEvent.getDiscounts());
    nameController.text = widget.data?.name ?? '';
    descriptionController.text = widget.data?.description ?? '';
    discountController.text = widget.data?.value?.replaceAll('.00', '') ?? '';
    super.initState();
  }

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final discountController = TextEditingController();
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
          const Text('Tambah Diskon'),
          const Spacer(),
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: context.deviceWidth / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: nameController,
                label: 'Nama Diskon',
                onChanged: (value) {},
              ),
              const SpaceHeight(24.0),
              CustomTextField(
                controller: descriptionController,
                label: 'Deskripsi (Opsional)',
                onChanged: (value) {},
              ),
              const SpaceHeight(24.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: CustomTextField(
                      controller: TextEditingController(text: 'Presentase'),
                      label: 'Nilai',
                      suffixIcon: const Icon(Icons.chevron_right),
                      onChanged: (value) {},
                      readOnly: true,
                    ),
                  ),
                  const SpaceWidth(14.0),
                  Flexible(
                    child: CustomTextField(
                      showLabel: false,
                      controller: discountController,
                      label: 'Percent',
                      prefixIcon: const Icon(Icons.percent),
                      onChanged: (value) {},
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SpaceHeight(24.0),
              widget.data == null
                  ? BlocConsumer<AddDiscountBloc, AddDiscountState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          success: () {
                            context
                                .read<DiscountBloc>()
                                .add(const DiscountEvent.getDiscounts());
                          },
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(orElse: () {
                          return Button.filled(
                            onPressed: () {
                              context.read<AddDiscountBloc>().add(
                                    AddDiscountEvent.addDiscount(
                                      name: nameController.text,
                                      description: descriptionController.text,
                                      value: int.parse(discountController.text),
                                    ),
                                  );
                              context
                                  .read<DiscountBloc>()
                                  .add(const DiscountEvent.getDiscounts());
                              context.pop();
                            },
                            label: 'Simpan Diskon',
                          );
                        }, loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                      },
                    )
                  : BlocConsumer<EditDiscountBloc, EditDiscountState>(
                      listener: (context, state) {
                        state.maybeWhen(
                            orElse: () {},
                            success: () {
                              context
                                  .read<DiscountBloc>()
                                  .add(const DiscountEvent.getDiscounts());
                            });
                      },
                      builder: (context, state) {
                        return state.maybeWhen(orElse: () {
                          return Button.filled(
                            onPressed: () {
                              context.read<EditDiscountBloc>().add(
                                  EditDiscountEvent.editDiscount(
                                      id: widget.data!.id.toString(),
                                      name: nameController.text,
                                      description: descriptionController.text,
                                      value: int.parse(discountController.text)
                                          .toDouble()));
                              context
                                  .read<DiscountBloc>()
                                  .add(const DiscountEvent.getDiscounts());
                              context.pop();
                            },
                            label: 'Simpan Diskon',
                          );
                        }, loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
