import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_apps/core/core.dart';

import '../../../core/components/loading.dart';
import '../../setting/bloc/discount/discount_bloc.dart';
import '../bloc/checkout/checkout_bloc.dart';

class DiscountDialog extends StatefulWidget {
  const DiscountDialog({super.key});

  @override
  State<DiscountDialog> createState() => _DiscountDialogState();
}

class _DiscountDialogState extends State<DiscountDialog> {
  @override
  void initState() {
    context.read<DiscountBloc>().add(const DiscountEvent.getDiscounts());
    super.initState();
  }

  int discountIdSelected = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountBloc, DiscountState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: LoadingIcon()),
          loaded: (discounts) {
            return AlertDialog(
              title: Stack(
                alignment: Alignment.center,
                children: [
                  const Text(
                    'DISKON',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: AppColors.primary,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: discounts
                    .map(
                      (discount) => ListTile(
                        title: Text('Nama Diskon: ${discount.name}'),
                        subtitle: Text('Potongan harga (${discount.value}%)'),
                        contentPadding: EdgeInsets.zero,
                        textColor: AppColors.primary,
                        trailing: Checkbox(
                          value: discount.id == discountIdSelected,
                          onChanged: (value) {
                            setState(() {
                              discountIdSelected = discount.id!;
                              context.read<CheckoutBloc>().add(
                                    CheckoutEvent.addDiscount(
                                      discount,
                                    ),
                                  );
                            });
                          },
                        ),
                        onTap: () {
                          // context.pop();
                        },
                      ),
                    )
                    .toList(),
              ),
            );
          },
          error: (message) => Center(child: Text(message)),
        );
      },
    );
  }
}
