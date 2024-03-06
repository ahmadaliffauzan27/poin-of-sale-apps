import 'package:flutter/material.dart';
import 'package:flutter_pos_apps/core/extensions/build_context_ext.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../../home/models/product_category.dart';
import '../models/discount_model.dart';

class FormDiscountDialog extends StatelessWidget {
  final DiscountModel? data;
  const FormDiscountDialog({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: data?.name ?? '');
    final codeController = TextEditingController(text: data?.code ?? '');
    final descriptionController =
        TextEditingController(text: data?.description ?? '');
    final discountController =
        TextEditingController(text: data?.discount.toString() ?? '');
    final categoryController =
        ValueNotifier<ProductCategory>(data?.category ?? ProductCategory.food);
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.close),
          ),
          Text(data == null ? 'Tambah Diskon' : 'Edit Diskon'),
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
              Button.filled(
                onPressed: () {
                  if (data == null) {
                    // TODO: do add discount
                  } else {
                    // TODO: do edit discount
                  }
                  context.pop();
                },
                label: data == null ? 'Simpan Diskon' : 'Perbarui Diskon',
              )
            ],
          ),
        ),
      ),
    );
  }
}
