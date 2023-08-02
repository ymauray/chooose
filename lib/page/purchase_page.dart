import 'package:chooose/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchasePage extends ConsumerWidget {
  const PurchasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Achats'),
      ),
      body: FutureBuilder(
        future: Purchases.getOfferings(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final offerings = snapshot.data as Offerings;
            final offering = offerings.current;
            final package = offering!.availablePackages.first;
            final product = package.storeProduct;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(product.priceString),
                  TextButton(
                    onPressed: () async {
                      //final purchase = await Purchases.purchasePackage(package);
                      //await ref.read(itemListsProvider.notifier).addList();
                      final purchaserInfo =
                          await Purchases.purchasePackage(package);
                      if (purchaserInfo
                              .entitlements.all['full_access']?.isActive ??
                          false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Merci pour votre achat !'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Achat annulé'),
                          ),
                        );
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text('Acheter'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
