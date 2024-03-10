import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_apps/core/core.dart';
import 'package:intl/intl.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../bloc/checkout/checkout_bloc.dart';
import '../bloc/order/order_bloc.dart';
import '../models/product_category.dart';
import '../models/product_model.dart';
import '../models/product_qty.dart';
import '../widgets/order_menu.dart';
import '../widgets/success_payment_dialog.dart';

class ConfirmPaymentPage extends StatefulWidget {
  const ConfirmPaymentPage({super.key});

  @override
  State<ConfirmPaymentPage> createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {
  // Variabel untuk menentukan apakah tombol 'Cash' atau 'QRIS' dipilih
  bool isCashSelected = true; // Defaultnya 'Cash' terpilih
  bool isQRISSelected = false; // 'QRIS' tidak terpilih

  String paymentMethod = 'Cash';
  void updateTotalPrice(int amount) {
    totalPriceController.text = amount.toString();
  }

  @override
  void dispose() {
    totalPriceController.dispose();
    super.dispose();
  }

  final totalPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    totalPriceController.addListener(() {
      final text = totalPriceController.text;
      final value = int.tryParse(text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      final newText =
          formatCurrency(value); // Menggunakan fungsi formatCurrency
      if (newText != text) {
        totalPriceController.value = totalPriceController.value.copyWith(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
          composing: TextRange.empty,
        );
      }
    });
  }

  String formatCurrency(int amount) {
    // Menggunakan formatter tanpa simbol mata uang
    final formatter = NumberFormat("#,##0", "id_ID");
    return 'Rp ${formatter.format(amount)}'; // Menambahkan simbol mata uang di sini
  }

  final products = [
    ProductModel(
        image: Assets.images.product1.path,
        name: 'Vanila Late Vanila itu',
        category: ProductCategory.drink,
        price: 200000,
        stock: 10),
    ProductModel(
        image: Assets.images.product2.path,
        name: 'V60',
        category: ProductCategory.drink,
        price: 1200000,
        stock: 10),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Hero(
        tag: 'confirmation_screen',
        child: Scaffold(
          body: Row(
            children: [
              // LEFT CONTENT
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     const Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           'Konfirmasi',
                        //           style: TextStyle(
                        //             color: AppColors.primary,
                        //             fontSize: 20,
                        //             fontWeight: FontWeight.w600,
                        //           ),
                        //         ),
                        //         Text(
                        //           'Orders #1',
                        //           style: TextStyle(
                        //             fontSize: 16,
                        //             fontWeight: FontWeight.w500,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     GestureDetector(
                        //       onTap: () {},
                        //       child: Container(
                        //         padding: const EdgeInsets.all(16.0),
                        //         height: 60.0,
                        //         width: 60.0,
                        //         decoration: const BoxDecoration(
                        //           color: AppColors.primary,
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(8.0)),
                        //         ),
                        //         child: const Icon(
                        //           Icons.add,
                        //           color: AppColors.white,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SpaceHeight(8.0),
                        // const Divider(),
                        const SpaceHeight(28.0),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Item',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 160,
                            ),
                            SizedBox(
                              width: 50.0,
                              child: Text(
                                'Qty',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                'Price',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SpaceHeight(8),
                        const Divider(),
                        const SpaceHeight(8),
                        BlocBuilder<CheckoutBloc, CheckoutState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () => const Center(
                                child: Text('No Items'),
                              ),
                              loaded: (products, discount, tax, service) {
                                if (products.isEmpty) {
                                  return const Center(
                                    child: Text('No Items'),
                                  );
                                }
                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      OrderMenu(data: products[index]),
                                  separatorBuilder: (context, index) =>
                                      const SpaceHeight(16.0),
                                  itemCount: products.length,
                                );
                              },
                            );
                          },
                        ),
                        const SpaceHeight(16.0),
                        const SpaceHeight(8.0),
                        const Divider(),
                        const SpaceHeight(8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Pajak',
                              style: TextStyle(color: AppColors.grey),
                            ),
                            BlocBuilder<CheckoutBloc, CheckoutState>(
                              builder: (context, state) {
                                final tax = state.maybeWhen(
                                  orElse: () => 0,
                                  loaded: (products, discount, tax, service) =>
                                      tax,
                                );
                                final price = state.maybeWhen(
                                  orElse: () => 0,
                                  loaded: (products, discount, tax, service) =>
                                      products.fold(
                                    0,
                                    (previousValue, element) =>
                                        previousValue +
                                        (element.product.price! *
                                            element.quantity),
                                  ),
                                );

                                final discount = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (products, discount, tax,
                                        serviceCharge) {
                                      if (discount == null) {
                                        return 0;
                                      }
                                      return discount.value!
                                          .replaceAll('.00', '')
                                          .toIntegerFromText;
                                    });

                                final subTotal =
                                    price - (discount / 100 * price);
                                final finalTax = subTotal * 0.11;
                                return Text(
                                  '$tax % (${finalTax.toInt().currencyFormatRp})',
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SpaceHeight(16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Diskon',
                              style: TextStyle(color: AppColors.grey),
                            ),
                            BlocBuilder<CheckoutBloc, CheckoutState>(
                              builder: (context, state) {
                                final discount = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (products, discount, tax,
                                        serviceCharge) {
                                      if (discount == null) {
                                        return 0;
                                      }
                                      return discount.value!
                                          .replaceAll('.00', '')
                                          .toIntegerFromText;
                                    });

                                final subTotal = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded:
                                        (products, discount, tax, service) =>
                                            products.fold(
                                              0,
                                              (previousValue, element) =>
                                                  previousValue +
                                                  (element.product.price! *
                                                      element.quantity),
                                            ));

                                final finalDiscount = discount / 100 * subTotal;
                                return Text(
                                  finalDiscount.toInt().currencyFormatRp,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SpaceHeight(16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sub total',
                              style: TextStyle(color: AppColors.grey),
                            ),
                            BlocBuilder<CheckoutBloc, CheckoutState>(
                              builder: (context, state) {
                                final price = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded:
                                        (products, discount, tax, service) =>
                                            products.fold(
                                              0,
                                              (previousValue, element) =>
                                                  previousValue +
                                                  (element.product.price! *
                                                      element.quantity),
                                            ));
                                return Text(
                                  price.currencyFormatRp,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SpaceHeight(16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            BlocBuilder<CheckoutBloc, CheckoutState>(
                              builder: (context, state) {
                                final price = state.maybeWhen(
                                  orElse: () => 0,
                                  loaded: (products, discount, tax, service) =>
                                      products.fold(
                                    0,
                                    (previousValue, element) =>
                                        previousValue +
                                        (element.product.price! *
                                            element.quantity),
                                  ),
                                );

                                final discount = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (products, discount, tax,
                                        serviceCharge) {
                                      if (discount == null) {
                                        return 0;
                                      }
                                      return discount.value!
                                          .replaceAll('.00', '')
                                          .toIntegerFromText;
                                    });

                                final subTotal =
                                    price - (discount / 100 * price);
                                final tax = subTotal * 0.11;
                                final total = subTotal + tax;

                                totalPriceController.text =
                                    total.ceil().toString();
                                // Future.microtask(() {
                                //   setState(() {
                                //     totalPriceController.text =
                                //         total.ceil().toString();
                                //   });
                                // });

                                return Text(
                                  total.ceil().currencyFormatRp,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // RIGHT CONTENT
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pembayaran',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Text(
                              '2 opsi pembayaran tersedia',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SpaceHeight(8.0),
                            const Divider(),
                            const SpaceHeight(8.0),
                            const Text(
                              'Metode Bayar',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SpaceHeight(12.0),
                            Row(
                              children: [
                                Button.filled(
                                  color: AppColors.grey,
                                  width: 120.0,
                                  height: 50.0,
                                  onPressed: () {
                                    setState(() {
                                      paymentMethod = 'Cash';
                                      isCashSelected = true;
                                      isQRISSelected = false;
                                    });
                                  },
                                  isSelected: isCashSelected,
                                  label: 'Cash',
                                ),
                                const SpaceWidth(8.0),
                                Button.outlined(
                                  textColor: Colors.white,
                                  width: 120.0,
                                  height: 50.0,
                                  onPressed: () {
                                    setState(() {
                                      paymentMethod = 'QRIS';
                                      isCashSelected = false;
                                      isQRISSelected = true;
                                    });
                                  },
                                  isSelected: isQRISSelected,
                                  label: 'QRIS',
                                  // disabled: true,
                                ),
                              ],
                            ),
                            const SpaceHeight(8.0),
                            const Divider(),
                            const SpaceHeight(8.0),
                            const Text(
                              'Total Bayar',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SpaceHeight(12.0),
                            TextFormField(
                              controller: totalPriceController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                hintText: 'Total pembayaran',
                              ),
                            ),
                            const SpaceHeight(45.0),

                            //create uang pas button from checkout_bloc
                            BlocBuilder<CheckoutBloc, CheckoutState>(
                              builder: (context, state) {
                                final price = state.maybeWhen(
                                  orElse: () => 0,
                                  loaded: (products, discount, tax, service) =>
                                      products.fold(
                                    0,
                                    (previousValue, element) =>
                                        previousValue +
                                        (element.product.price! *
                                            element.quantity),
                                  ),
                                );

                                final discount = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (products, discount, tax,
                                        serviceCharge) {
                                      if (discount == null) {
                                        return 0;
                                      }
                                      return discount.value!
                                          .replaceAll('.00', '')
                                          .toIntegerFromText;
                                    });

                                final subTotal =
                                    price - (discount / 100 * price);
                                final finalTax = subTotal * 0.11;
                                final total = subTotal + finalTax;

                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Button.filled(
                                          width: 150.0,
                                          onPressed: () {
                                            updateTotalPrice(total.toInt());
                                          },
                                          label: 'UANG PAS',
                                        ),
                                        const SpaceWidth(20.0),
                                        Button.filled(
                                          width: 150.0,
                                          onPressed: () {
                                            updateTotalPrice(20000);
                                          },
                                          label: 'Rp 20.000',
                                        ),
                                        const SpaceWidth(20.0),
                                        Button.filled(
                                          width: 150.0,
                                          onPressed: () {
                                            updateTotalPrice(50000);
                                          },
                                          label: 'Rp 50.000',
                                        ),
                                        const SpaceWidth(20.0),
                                        Button.filled(
                                          width: 150.0,
                                          onPressed: () {
                                            updateTotalPrice(100000);
                                          },
                                          label: 'Rp 100.000',
                                        ),
                                      ],
                                    ),
                                    const SpaceHeight(20.0),
                                    Row(
                                      children: [
                                        Button.filled(
                                          width: 150.0,
                                          onPressed: () {
                                            updateTotalPrice(200000);
                                          },
                                          label: 'Rp 200.000',
                                        ),
                                        const SpaceWidth(20.0),
                                        Button.filled(
                                          width: 150.0,
                                          onPressed: () {
                                            updateTotalPrice(250000);
                                          },
                                          label: 'Rp 250.000',
                                        ),
                                        const SpaceWidth(20.0),
                                        Button.filled(
                                          width: 150.0,
                                          onPressed: () {
                                            updateTotalPrice(300000);
                                          },
                                          label: 'Rp 300.000',
                                        ),
                                        const SpaceWidth(20.0),
                                        Button.filled(
                                          width: 150.0,
                                          onPressed: () {
                                            updateTotalPrice(500000);
                                          },
                                          label: 'Rp 500.000',
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SpaceHeight(100.0),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ColoredBox(
                          color: AppColors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 16.0),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Button.outlined(
                                    onPressed: () => context.pop(),
                                    label: 'Batalkan',
                                  ),
                                ),
                                const SpaceWidth(8.0),
                                BlocBuilder<CheckoutBloc, CheckoutState>(
                                  builder: (context, state) {
                                    final discount = state.maybeWhen(
                                        orElse: () => 0,
                                        loaded: (products, discount, tax,
                                            serviceCharge) {
                                          if (discount == null) {
                                            return 0;
                                          }
                                          return discount.value!
                                              .replaceAll('.00', '')
                                              .toIntegerFromText;
                                        });

                                    final price = state.maybeWhen(
                                      orElse: () => 0,
                                      loaded:
                                          (products, discount, tax, service) =>
                                              products.fold(
                                        0,
                                        (previousValue, element) =>
                                            previousValue +
                                            (element.product.price! *
                                                element.quantity),
                                      ),
                                    );

                                    //     final discount = state.maybeWhen(
                                    //     orElse: () => 0,
                                    //     loaded: (products, discount, tax,
                                    //         serviceCharge) {
                                    //       if (discount == null) {
                                    //         return 0;
                                    //       }
                                    //       return discount.value!
                                    //           .replaceAll('.00', '')
                                    //           .toIntegerFromText;
                                    //     });

                                    // final subTotal =
                                    //     price - (discount / 100 * price);

                                    // final total = subTotal + tax;

                                    final subTotal =
                                        price - (discount / 100 * price);

                                    final tax = subTotal * 0.11;

                                    final totalDiscount =
                                        discount / 100 * price;
                                    final finalTax = subTotal * 0.11;

                                    final total = subTotal + tax;

                                    List<ProductQuantity> items =
                                        state.maybeWhen(
                                      orElse: () => [],
                                      loaded:
                                          (products, discount, tax, service) =>
                                              products,
                                    );
                                    final totalQty = items.fold(
                                      0,
                                      (previousValue, element) =>
                                          previousValue + element.quantity,
                                    );

                                    final totalPrice = subTotal + finalTax;

                                    return Flexible(
                                      child: Button.filled(
                                        onPressed: () async {
                                          final int enteredTotal =
                                              totalPriceController
                                                  .text.toIntegerFromText;

                                          if (enteredTotal < total) {
                                            return showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      backgroundColor: AppColors
                                                          .buttonOn
                                                          .withOpacity(1),
                                                      title: const Text(
                                                        'Peringatan',
                                                        style: TextStyle(
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                      ),
                                                      content: const Text(
                                                        'Pembayaran kurang dari total harga',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .white),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            context.pop();
                                                          },
                                                          child: const Text(
                                                              'OK',
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .white)),
                                                        ),
                                                      ],
                                                    ));
                                          }
                                          context
                                              .read<OrderBloc>()
                                              .add(OrderEvent.order(
                                                items,
                                                discount,
                                                finalTax.toInt(),
                                                0,
                                                totalPriceController
                                                    .text.toIntegerFromText,
                                                paymentMethod,
                                              ));
                                          await showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) =>
                                                SuccessPaymentDialog(
                                              data: items,
                                              totalQty: totalQty,
                                              totalPrice: totalPrice.toInt(),
                                              paymentMethode: paymentMethod,
                                              paymentAmount:
                                                  totalPriceController
                                                      .text.toIntegerFromText,
                                              pembayaranUser:
                                                  totalPriceController
                                                      .text.toIntegerFromText,
                                              totalTax: finalTax.toInt(),
                                              totalDiscount:
                                                  totalDiscount.toInt(),
                                              subTotal: subTotal.toInt(),
                                              normalPrice: price,
                                            ),
                                          );
                                        },
                                        label: 'Bayar',
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
