import 'package:chooose/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class InfoPage extends ConsumerWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Info'),
        actions: const [],
      ),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Image.asset('assets/img/choooose.png'),
            ),
            const SizedBox(
              height: 16,
            ),
            FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final packageInfo = snapshot.data;
                  return ListTile(
                    title: const Text('Version'),
                    subtitle: Text(
                      '${packageInfo!.version} (${packageInfo.buildNumber})',
                    ),
                  );
                } else {
                  return const ListTile(
                    title: Text('Version'),
                    subtitle: Text(
                      'x.y.z (b)',
                    ),
                  );
                }
              },
            ),
            const ListTile(
              title: Text('Author'),
              subtitle: Text('Yannick Mauray'),
            ),
            const ListTile(
              title: Text('License'),
              subtitle: Text('LGPL-3.0'),
            ),
          ],
        ),
      ),
    );
  }
}
