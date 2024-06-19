import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_apps/core/core.dart';
import 'package:flutter_pos_apps/presentation/home/dialog/service_dialog.dart';
import 'package:flutter_pos_apps/presentation/home/dialog/tax_dialog.dart';
import 'package:flutter_pos_apps/presentation/home/widgets/order_menu.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../bloc/checkout/checkout_bloc.dart';
import '../bloc/local_product/local_product_bloc.dart';
import '../dialog/discount_dialog.dart';
import '../widgets/column_button.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/home_title.dart';
import '../widgets/product_card.dart';
import 'confirm_payment_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  @override
  void initState() {
    // searchResults = products;
    context
        .read<LocalProductBloc>()
        .add(const LocalProductEvent.getLocalProduct());
    super.initState();
  }

  void onCategoryTap(int index) {
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'confirmation_screen',
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        HomeTitle(
                          controller: searchController,
                          onChanged: (value) {
                            context.read<LocalProductBloc>().add(
                                LocalProductEvent.searchProduct(query: value));
                          },
                        ),
                        const SizedBox(height: 24),
                        CustomTabBar(
                          tabTitles: const ['Semua', 'Makanan', 'Minuman'],
                          initialTabIndex: 0,
                          tabViews: [
                            SizedBox(
                              child: BlocBuilder<LocalProductBloc,
                                  LocalProductState>(
                                builder: (context, state) {
                                  return state.maybeWhen(orElse: () {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }, loading: () {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }, loaded: (products) {
                                    if (products.isEmpty) {
                                      return const Padding(
                                        padding: EdgeInsets.only(top: 200),
                                        child: Center(
                                          child: Text('Produk Tidak Ditemukan'),
                                        ),
                                      );
                                    }
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: products.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.85,
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 30.0,
                                        mainAxisSpacing: 30.0,
                                      ),
                                      itemBuilder: (context, index) =>
                                          ProductCard(
                                        data: products[index],
                                        onCartButton: () {},
                                      ),
                                    );
                                  });
                                },
                              ),
                            ),

                            //Tab makanan
                            SizedBox(
                              child: BlocBuilder<LocalProductBloc,
                                  LocalProductState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    orElse: () {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    loading: () {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    loaded: (products) {
                                      if (products.isEmpty) {
                                        return const Center(
                                          child: Text('data kosong'),
                                        );
                                      }
                                      return GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: products
                                            .where((element) =>
                                                element.category!.id == 1)
                                            .toList()
                                            .length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.85,
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 30.0,
                                          mainAxisSpacing: 30.0,
                                        ),
                                        itemBuilder: (context, index) =>
                                            ProductCard(
                                          data: products
                                              .where((element) =>
                                                  element.category!.id == 1)
                                              .toList()[index],
                                          onCartButton: () {},
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),

                            //Tab minuman
                            SizedBox(
                              child: BlocBuilder<LocalProductBloc,
                                  LocalProductState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    orElse: () {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    loading: () {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    loaded: (products) {
                                      if (products.isEmpty) {
                                        return const Center(
                                          child: Text('data kosong'),
                                        );
                                      }
                                      return GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: products
                                            .where((element) =>
                                                element.category!.id == 2)
                                            .toList()
                                            .length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.85,
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 30.0,
                                          mainAxisSpacing: 30.0,
                                        ),
                                        itemBuilder: (context, index) =>
                                            ProductCard(
                                          data: products
                                              .where((element) =>
                                                  element.category!.id == 2)
                                              .toList()[index],
                                          onCartButton: () {},
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),

                            //Tab snack
                            SizedBox(
                              child: BlocBuilder<LocalProductBloc,
                                  LocalProductState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    orElse: () {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    loading: () {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    loaded: (products) {
                                      if (products.isEmpty) {
                                        return const Center(
                                          child: Text('data kosong'),
                                        );
                                      }
                                      return GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: products
                                            .where((element) =>
                                                element.category!.id == 3)
                                            .toList()
                                            .length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.85,
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 30.0,
                                          mainAxisSpacing: 30.0,
                                        ),
                                        itemBuilder: (context, index) =>
                                            ProductCard(
                                          data: products
                                              .where((element) =>
                                                  element.category!.id == 3)
                                              .toList()[index],
                                          onCartButton: () {},
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),

//tab kerupuk
                            SizedBox(
                              child: BlocBuilder<LocalProductBloc,
                                  LocalProductState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    orElse: () {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    loading: () {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    loaded: (products) {
                                      if (products.isEmpty) {
                                        return const Center(
                                          child: Text('data kosong'),
                                        );
                                      }
                                      return GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: products
                                            .where((element) =>
                                                element.category!.id == 4)
                                            .toList()
                                            .length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.85,
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 30.0,
                                          mainAxisSpacing: 30.0,
                                        ),
                                        itemBuilder: (context, index) =>
                                            ProductCard(
                                          data: products
                                              .where((element) =>
                                                  element.category!.id == 4)
                                              .toList()[index],
                                          onCartButton: () {},
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Text(
                          //   'Orders #1',
                          //   style: TextStyle(
                          //     color: AppColors.primary,
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),
                          // const SpaceHeight(8.0),
                          // Row(
                          //   children: [
                          //     Button.filled(
                          //       width: 120.0,
                          //       height: 40,
                          //       onPressed: () {},
                          //       label: 'Dine In',
                          //     ),
                          //     const SpaceWidth(8.0),
                          //     Button.outlined(
                          //       width: 100.0,
                          //       height: 40,
                          //       onPressed: () {},
                          //       label: 'To Go',
                          //     ),
                          //   ],
                          // ),
                          const SpaceHeight(8.0),
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
                                width: 130,
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
                                  orElse: () => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 80),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Assets.icons.noProduct.svg(),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Text(
                                                'Belum ada produk yang\nditambahkan',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  loaded: (products, discount, tax, service) {
                                    if (products.isEmpty) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 80),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Assets.icons.noProduct.svg(),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Text(
                                                'Belum ada produk yang\nditambahkan',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                    return ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            OrderMenu(data: products[index]),
                                        separatorBuilder: (context, index) =>
                                            const SpaceHeight(1),
                                        itemCount: products.length);
                                  });
                            },
                          ),
                          const SpaceHeight(8.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ColumnButton(
                                label: 'Diskon',
                                svgGenImage: Assets.icons.diskon,
                                onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const DiscountDialog()),
                              ),
                              ColumnButton(
                                label: 'Pajak',
                                svgGenImage: Assets.icons.pajak,
                                onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => const TaxDialog()),
                              ),
                              ColumnButton(
                                label: 'Layanan',
                                svgGenImage: Assets.icons.layanan,
                                onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const ServiceDialog()),
                              ),
                            ],
                          ),
                          // const SpaceHeight(100),
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
                                      loaded:
                                          (products, discount, tax, service) {
                                        if (tax == null) {
                                          return 0;
                                        }
                                        return tax.value!.toIntegerFromText;
                                      });
                                  return Text(
                                    '$tax %'.replaceAll('00', ''),
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SpaceHeight(8.0),
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
                                      loaded:
                                          (products, discount, tax, service) {
                                        if (discount == null) {
                                          return 0;
                                        }
                                        return discount
                                            .value!.toIntegerFromText;
                                      });
                                  return Text(
                                    '$discount %'.replaceAll('00', ''),
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SpaceHeight(8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(color: AppColors.grey),
                              ),
                              BlocBuilder<CheckoutBloc, CheckoutState>(
                                builder: (context, state) {
                                  int price = state.maybeWhen(
                                      orElse: () => 0,
                                      loaded:
                                          (products, discount, tax, service) {
                                        if (products.isEmpty) {
                                          return 0;
                                        }
                                        return products
                                            .map((e) =>
                                                e.product.price! * e.quantity)
                                            .reduce((a, b) => a + b);
                                      });
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
                          const SpaceHeight(50.0),
                        ],
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: ColoredBox(
                    //     color: AppColors.white,
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 24.0, vertical: 16.0),
                    //       child: Button.filled(
                    //         onPressed: () {
                    //           context.push(const ConfirmPaymentPage());
                    //         },
                    //         label: 'Lanjutkan Pembayaran',
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // make disabled button if no product
                    BlocBuilder<CheckoutBloc, CheckoutState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () => const SizedBox(),
                          loaded: (products, discount, tax, service) {
                            if (products.isEmpty) {
                              return Align(
                                alignment: Alignment.bottomCenter,
                                child: ColoredBox(
                                  color: AppColors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0, vertical: 16.0),
                                    child: Button.filled(
                                      color: AppColors.disabled,
                                      onPressed: () {},
                                      label: 'Lanjutkan Pembayaran',
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Align(
                              alignment: Alignment.bottomCenter,
                              child: ColoredBox(
                                color: AppColors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0, vertical: 16.0),
                                  child: Button.filled(
                                    onPressed: () {
                                      context.push(const ConfirmPaymentPage());
                                    },
                                    label: 'Lanjutkan Pembayaran',
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: unused_element
class _IsEmpty extends StatelessWidget {
  const _IsEmpty();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ignore: deprecated_member_use_from_same_package
          Assets.icons.noProduct.svg(color: AppColors.buttonOf),
          const SizedBox(height: 80.0),
          const Text(
            'Belum Ada Produk',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
