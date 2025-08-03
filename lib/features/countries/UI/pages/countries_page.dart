import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/countries_provider.dart';

class CountriesPage extends ConsumerWidget {
  const CountriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countriesAsync = ref.watch(countriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Countries')),
      body: countriesAsync.when(
        data: (countries) => ListView.builder(
          itemCount: countries.length,
          itemBuilder: (context, index) {
            final country = countries[index];
            return ListTile(
              leading: Text(country['emoji'] ?? ''),
              title: Text(country['name'] ?? ''),
              subtitle: Text(
                '${country['capital'] ?? 'No Capital'} - ${country['continent']['name'] ?? ''}',
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
