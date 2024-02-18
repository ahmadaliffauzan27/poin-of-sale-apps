import 'package:flutter/material.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../models/product_category.dart';
import '../models/product_model.dart';
import '../widgets/column_button.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/home_title.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  List<ProductModel> searchResults = [];
  final List<ProductModel> products = [
    ProductModel(
        image: Assets.images.menu1.path,
        name: 'Express Bowl Ayam Rica',
        category: ProductCategory.food,
        price: 32000,
        stock: 10),
    ProductModel(
        image: Assets.images.menu2.path,
        name: 'Crispy Black Pepper Sauce',
        category: ProductCategory.food,
        price: 36000,
        stock: 10),
    ProductModel(
        image: Assets.images.menu3.path,
        name: 'Mie Ayam Teriyaki',
        category: ProductCategory.food,
        price: 33000,
        stock: 10),
    ProductModel(
        image: Assets.images.menu4.path,
        name: 'Nasi Ayam Teriyaki',
        category: ProductCategory.food,
        price: 21000,
        stock: 10),
    ProductModel(
        image: Assets.images.menu5.path,
        name: ' Katsu Teriyaki Saos',
        category: ProductCategory.food,
        price: 40000,
        stock: 10),
    ProductModel(
        image: Assets.images.menu6.path,
        name: 'Sapo Tahu Ayam',
        category: ProductCategory.food,
        price: 41000,
        stock: 10),
    ProductModel(
        image: Assets.images.menu7.path,
        name: ' Sapo Tahu Sapi',
        category: ProductCategory.food,
        price: 44000,
        stock: 10),
    ProductModel(
        image: Assets.images.menu8.path,
        name: 'Chicken Cordon Bleu',
        category: ProductCategory.food,
        price: 45000,
        stock: 10),
    ProductModel(
        image: Assets.images.menu10.path,
        name: 'Fish & Chips ',
        category: ProductCategory.food,
        price: 35000,
        stock: 10),
    ProductModel(
        image: Assets.images.menu11.path,
        name: 'Bihun Ayam',
        category: ProductCategory.food,
        price: 39000,
        stock: 10),
    ProductModel(
        image: Assets.images.menu12.path,
        name: 'Bihun Goreng Ayam',
        category: ProductCategory.food,
        price: 38000,
        stock: 10),
    ProductModel(
        image: Assets.images.menu13.path,
        name: 'Nasi Goreng Special',
        category: ProductCategory.food,
        price: 35000,
        stock: 10),
    ProductModel(
        image: Assets.images.menu14.path,
        name: 'Nasi Cap Cay',
        category: ProductCategory.food,
        price: 40000,
        stock: 10),
    ProductModel(
        image: Assets.images.drink1.path,
        name: 'Teh Tarik',
        category: ProductCategory.drink,
        price: 20000,
        stock: 10),
    ProductModel(
        image: Assets.images.drink2.path,
        name: 'Thai Tea',
        category: ProductCategory.drink,
        price: 22000,
        stock: 10),
    ProductModel(
        image: Assets.images.drink3.path,
        name: 'Jus Melon',
        category: ProductCategory.drink,
        price: 25000,
        stock: 10),
    ProductModel(
        image: Assets.images.drink4.path,
        name: 'Jus Stawberry',
        category: ProductCategory.drink,
        price: 24000,
        stock: 10),
    ProductModel(
        image: Assets.images.drink5.path,
        name: 'Air Mineral Botol',
        category: ProductCategory.drink,
        price: 6000,
        stock: 10),
    ProductModel(
        image: Assets.images.drink6.path,
        name: 'Jus Alpukat',
        category: ProductCategory.drink,
        price: 25000,
        stock: 10),
    ProductModel(
        image: Assets.images.menu14.path,
        name: 'Caramel Candy Blend',
        category: ProductCategory.drink,
        price: 30000,
        stock: 10),
  ];

  @override
  void initState() {
    searchResults = products;
    super.initState();
  }

  void onCategoryTap(int index) {
    searchController.clear();
    if (index == 0) {
      searchResults = products;
    } else {
      searchResults = products
          .where((e) => e.category.index.toString().contains(index.toString()))
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
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
                            searchResults = products
                                .where((e) => e.name
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 24),
                        CustomTabBar(
                          tabTitles: const [
                            'Semua',
                            'Makanan',
                            'Minuman',
                            'Snack'
                          ],
                          initialTabIndex: 0,
                          tabViews: [
                            if (searchResults.isEmpty)
                              const Padding(
                                padding: EdgeInsets.only(top: 80.0),
                                child: _IsEmpty(),
                              )
                            else
                              SizedBox(
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: searchResults.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.85,
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 30.0,
                                    mainAxisSpacing: 30.0,
                                  ),
                                  itemBuilder: (context, index) => ProductCard(
                                    data: searchResults[index],
                                    onCartButton: () {},
                                  ),
                                ),
                              ),
                            if (searchResults
                                .where((element) => element.category.isFood)
                                .toList()
                                .isEmpty)
                              const Padding(
                                padding: EdgeInsets.only(top: 80.0),
                                child: _IsEmpty(),
                              )
                            else
                              SizedBox(
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: searchResults
                                      .where(
                                          (element) => element.category.isFood)
                                      .toList()
                                      .length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.85,
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 30.0,
                                    mainAxisSpacing: 30.0,
                                  ),
                                  itemBuilder: (context, index) => ProductCard(
                                    data: searchResults
                                        .where((element) =>
                                            element.category.isFood)
                                        .toList()[index],
                                    onCartButton: () {},
                                  ),
                                ),
                              ),
                            if (searchResults
                                .where((element) => element.category.isDrink)
                                .toList()
                                .isEmpty)
                              const Padding(
                                padding: EdgeInsets.only(top: 80.0),
                                child: _IsEmpty(),
                              )
                            else
                              SizedBox(
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: searchResults
                                      .where(
                                          (element) => element.category.isDrink)
                                      .toList()
                                      .length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.85,
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 30.0,
                                    mainAxisSpacing: 30.0,
                                  ),
                                  itemBuilder: (context, index) => ProductCard(
                                    data: searchResults
                                        .where((element) =>
                                            element.category.isDrink)
                                        .toList()[index],
                                    onCartButton: () {},
                                  ),
                                ),
                              ),
                            if (searchResults
                                .where((element) => element.category.isSnack)
                                .toList()
                                .isEmpty)
                              const Padding(
                                padding: EdgeInsets.only(top: 80.0),
                                child: _IsEmpty(),
                              )
                            else
                              SizedBox(
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: searchResults
                                      .where(
                                          (element) => element.category.isSnack)
                                      .toList()
                                      .length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.85,
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 30.0,
                                    mainAxisSpacing: 30.0,
                                  ),
                                  itemBuilder: (context, index) => ProductCard(
                                    data: searchResults
                                        .where((element) =>
                                            element.category.isSnack)
                                        .toList()[index],
                                    onCartButton: () {},
                                  ),
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
                          const Text(
                            'Orders #1',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SpaceHeight(8.0),
                          Row(
                            children: [
                              Button.filled(
                                width: 120.0,
                                height: 40,
                                onPressed: () {},
                                label: 'Dine In',
                              ),
                              const SpaceWidth(8.0),
                              Button.outlined(
                                width: 100.0,
                                height: 40,
                                onPressed: () {},
                                label: 'To Go',
                              ),
                            ],
                          ),
                          const SpaceHeight(16.0),
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
                          // BlocBuilder<CheckoutBloc, CheckoutState>(
                          //   builder: (context, state) {
                          //     return state.maybeWhen(
                          //       orElse: () => const Center(
                          //         child: Text('No Items'),
                          //       ),
                          //       success: (products, qty, price) {
                          //         if (products.isEmpty) {
                          //           return const Center(
                          //             child: Text('No Items'),
                          //           );
                          //         }
                          //         return ListView.separated(
                          //           shrinkWrap: true,
                          //           physics:
                          //               const NeverScrollableScrollPhysics(),
                          //           itemBuilder: (context, index) =>
                          //               OrderMenu(data: products[index]),
                          //           separatorBuilder: (context, index) =>
                          //               const SpaceHeight(1.0),
                          //           itemCount: products.length,
                          //         );
                          //       },
                          //     );
                          //   },
                          // ),
                          const SpaceHeight(8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ColumnButton(
                                label: 'Diskon',
                                svgGenImage: Assets.icons.diskon,
                                onPressed: () {},
                              ),
                              ColumnButton(
                                label: 'Pajak',
                                svgGenImage: Assets.icons.pajak,
                                onPressed: () {},
                              ),
                              ColumnButton(
                                label: 'Layanan',
                                svgGenImage: Assets.icons.layanan,
                                onPressed: () {},
                              ),
                            ],
                          ),
                          const SpaceHeight(8.0),
                          const Divider(),
                          const SpaceHeight(8.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pajak',
                                style: TextStyle(color: AppColors.grey),
                              ),
                              Text(
                                '11 %',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SpaceHeight(8.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Diskon',
                                style: TextStyle(color: AppColors.grey),
                              ),
                              Text(
                                'Rp. 0',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SpaceHeight(8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sub total',
                                style: TextStyle(color: AppColors.grey),
                              ),
                              // BlocBuilder<CheckoutBloc, CheckoutState>(
                              //   builder: (context, state) {
                              //     final price = state.maybeWhen(
                              //       orElse: () => 0,
                              //       success: (products, qty, price) => price,
                              //     );
                              //     return Text(
                              //       price.currencyFormatRp,
                              //       style: const TextStyle(
                              //         color: AppColors.primary,
                              //         fontWeight: FontWeight.w600,
                              //       ),
                              //     );
                              //   },
                              // ),
                            ],
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
                          child: Button.filled(
                            onPressed: () {
                              // context.push(const ConfirmPaymentPage());
                            },
                            label: 'Lanjutkan Pembayaran',
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
    );
  }
}

class _IsEmpty extends StatelessWidget {
  const _IsEmpty();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.noProduct.svg(),
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
