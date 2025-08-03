import 'package:adv_task_manager/core/providers/graphql_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final countriesProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final client = ref.watch(graphqlClientProvider);

  const query = r'''
    query {
      countries {
        code
        name
        emoji
        capital
        continent {
          name
        }
      }
    }
  ''';

  final result = await client.query(QueryOptions(document: gql(query)));

  if (result.hasException) {
    throw result.exception!;
  }

  final countries = result.data?['countries'] as List<dynamic>;
  return countries.map((e) => e as Map<String, dynamic>).toList();
});
