import 'package:adv_task_manager/core/constants/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final graphqlClientProvider = Provider<GraphQLClient>((ref) {
  final link = HttpLink(Constants.countriesApi);
  return GraphQLClient(
    link: link,
    cache: GraphQLCache(store: InMemoryStore()),
  );
});
