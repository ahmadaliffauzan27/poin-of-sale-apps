import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Import blocs yang diperlukan

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../data/datasources/product_local_remote_datasource.dart';
import '../bloc/sync_order/sync_order_bloc.dart';
import '../bloc/sync_product/sync_product_bloc.dart';

class SyncDataPage extends StatefulWidget {
  const SyncDataPage({Key? key}) : super(key: key);

  @override
  State<SyncDataPage> createState() => _SyncDataPageState();
}

class _SyncDataPageState extends State<SyncDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  const SpaceHeight(16.0),
                  BlocListener<SyncProductBloc, SyncProductState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        error: (message) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                        loaded: (productResponseModel) {
                          ProductLocalRemoteDatasource.instance
                              .deleteAllProducts();
                          ProductLocalRemoteDatasource.instance.insertProducts(
                            productResponseModel.data!,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sync Product Success'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      );
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12.0),
                      // ignore: deprecated_member_use_from_same_package
                      leading: Assets.icons.kelolaDiskon
                          // ignore: deprecated_member_use_from_same_package
                          .svg(color: AppColors.primary),
                      title: const Text('Sync Product'),
                      subtitle: const Text('Sync product dari server ke local'),
                      textColor: AppColors.primary,
                      onTap: () {
                        context
                            .read<SyncProductBloc>()
                            .add(const SyncProductEvent.syncProduct());
                      },
                    ),
                  ),
                  BlocListener<SyncOrderBloc, SyncOrderState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        error: (message) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                        loaded: () {
                          ProductLocalRemoteDatasource.instance
                              .deleteAllOrders();
                          ProductLocalRemoteDatasource.instance
                              .deleteAllOrderItems();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sync Order Success'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      );
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12.0),
                      // ignore: deprecated_member_use_from_same_package
                      leading: Assets.icons.kelolaPrinter
                          // ignore: deprecated_member_use_from_same_package
                          .svg(color: AppColors.primary),
                      title: const Text('Sync Order'),
                      subtitle: const Text('Sync order dari local ke server'),
                      textColor: AppColors.primary,
                      onTap: () {
                        context
                            .read<SyncOrderBloc>()
                            .add(const SyncOrderEvent.syncOrder());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
