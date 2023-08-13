import 'package:chooose/l10n/l10n_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchasePage extends ConsumerWidget {
  const PurchasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ColoredBox(
        color: Colors.orange,
        child: Center(
          child: Column(
            children: [
              Text(
                context.t.becomePremium,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Divider(color: Colors.white),
              ),
              Text(
                context.t.createUnlimitedLists,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Divider(color: Colors.white),
              ),
              Text(
                context.t.addUnlimidedElements,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Divider(color: Colors.white),
              ),
              const SizedBox(height: 32),
              FutureBuilder(
                future: Purchases.getOfferings(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final offerings = snapshot.data as Offerings;
                    final offering = offerings.current;
                    final package = offering!.availablePackages.first;
                    final product = package.storeProduct;
                    return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.purple),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          product.priceString,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      onPressed: () async {
                        try {
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
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Achat annulé'),
                              ),
                            );
                          }
                        } on PlatformException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.message ?? 'Erreur'),
                            ),
                          );
                        }
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
        /*
        child: FutureBuilder(
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
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
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
        */
      ),
    );
  }
}
