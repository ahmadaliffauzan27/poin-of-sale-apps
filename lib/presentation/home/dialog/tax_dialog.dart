import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_apps/core/core.dart';
import 'package:flutter_pos_apps/presentation/setting/bloc/tax/tax_bloc.dart';

import '../../../core/components/loading.dart';
import '../../setting/bloc/discount/discount_bloc.dart';
import '../bloc/checkout/checkout_bloc.dart';

class TaxDialog extends StatefulWidget {
  const TaxDialog({super.key});

  @override
  State<TaxDialog> createState() => _TaxDialogState();
}

class _TaxDialogState extends State<TaxDialog> {
  @override
  void initState() {
    context.read<TaxBloc>().add(const TaxEvent.getTaxs());
    super.initState();
  }

  int taxIdSelected = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxBloc, TaxState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: LoadingIcon()),
          loaded: (taxes) {
            return AlertDialog(
              title: Stack(
                alignment: Alignment.center,
                children: [
                  const Text(
                    'PAJAK',
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
                children: taxes
                    .map(
                      (tax) => ListTile(
                        subtitle: Text('Pajak (${tax.value}%)'),
                        contentPadding: EdgeInsets.zero,
                        textColor: AppColors.primary,
                        trailing: Checkbox(
                          value: tax.id == taxIdSelected,
                          onChanged: (value) {
                            setState(() {
                              taxIdSelected = tax.id!;
                              context.read<CheckoutBloc>().add(
                                    CheckoutEvent.addTax(
                                      tax,
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
