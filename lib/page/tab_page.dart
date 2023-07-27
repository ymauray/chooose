import 'package:chooose/page/home_page.dart';
import 'package:chooose/page/info_page.dart';
import 'package:chooose/provider/tab_inidex_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabPage extends ConsumerWidget {
  const TabPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(tabIndexProvider);

    return Scaffold(
      body: Builder(
        builder: (context) {
          if (tabIndex == 1) {
            return const InfoPage();
          } else {
            return const HomePage();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        onTap: (index) => ref.read(tabIndexProvider.notifier).activate(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
        ],
      ),
    );
  }
}
