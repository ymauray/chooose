import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/img/choooose.png'),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              "Envie d'un drone et d'une serrure connectée ?",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              "Envie d'aller en Ecosse et en Alaska ?",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Envie de demander une poupée et une tablette au Père Noël ?',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              "Ajouter ce que vous voulez dans l'app, et laissez-vous guider "
              'pour trier vos envies par ordre de priorité !',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Choooose !',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
