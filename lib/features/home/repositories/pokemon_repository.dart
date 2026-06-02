import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/network/api_client.dart';
import 'package:pokedex/core/network/api_response.dart';
import 'package:pokedex/core/network/dio_client.dart';
import 'package:pokedex/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/core/network/endpoints/pokemon_endpoints.dart';

final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepository(ApiClient(ref.watch(dioProvider)));
});

class PokemonRepository {
  final ApiClient apiClient;

  PokemonRepository(this.apiClient);

  Future<ApiResponse<List<PokemonModel>>> getPokemons({
    int limit = 10,
    int offset = 0,
  }) async {
    final response = await apiClient.get(
      PokemonEndpoints.getPokemons(limit: limit, offset: offset),
    );

    if (!response.success) {
      return ApiResponse.failure(
        response.message ?? 'Failed to fetch pokemons',
      );
    }

    try {
      final results = response.data['results'] as List;

      final pokemons = await Future.wait(
        results.map((pokemon) async {
          final detailResponse = await apiClient.get(pokemon['url']);

          return PokemonModel.fromJson(detailResponse.data);
        }),
      );

      return ApiResponse.success(pokemons);
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }
}
