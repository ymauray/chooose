import 'dart:io';

import 'package:chooose/l10n/l10n_extension.dart';
import 'package:chooose/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class InfoPage extends ConsumerWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final button = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ElevatedButton(
            onPressed: () async {
              await Navigator.of(context).pushNamed('/purchase');
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                context.t.premiumAccess,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Info'),
        actions: const [],
      ),
      body: Center(
        child: ListView(
          children: [
            Image.asset('assets/img/choooose_alpha.png'),
            ListTile(
              title: Text(
                'Version',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              subtitle: FutureBuilder(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final packageInfo = snapshot.data;
                    return Text(
                      '${packageInfo!.version} (${packageInfo.buildNumber})',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    );
                  } else {
                    return Text(
                      'x.y.z (b)',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    );
                  }
                },
              ),
            ),
            ListTile(
              title: Text(
                'Author',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                'Yannick Mauray',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text(
                'License',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                'LGPL-3.0',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            if (Platform.isIOS)
              FutureBuilder(
                future: Purchases.getCustomerInfo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final customerInfo = snapshot.data!;
                    final entitlements = customerInfo.entitlements.all;
                    final fullAccess = entitlements['full_access'];
                    if (fullAccess?.isActive ?? false) {
                      return ListTile(
                        title: Text(
                          context.t.premiumAccess,
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      return button;
                    }
                  } else {
                    return Text(context.t.retreivingInformations);
                  }
                },
              ),
            if (!Platform.isIOS) button,
          ],
        ),
      ),
    );
  }
}
