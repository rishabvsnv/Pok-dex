import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/network/api_client.dart';
import 'package:pokedex/core/network/api_response.dart';
import 'package:pokedex/core/network/dio_client.dart';
import 'package:pokedex/data/models/pokemon/pokemon_model.dart';
import 'package:pokedex/core/network/endpoints/pokemon_endpoints.dart';
import 'package:pokedex/features/search/models/pokemon_search_model.dart';

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

  Future<ApiResponse<PokemonModel>> getPokemonById(int id) async {
    final response = await apiClient.get(PokemonEndpoints.getPokemonById(id));

    if (!response.success) {
      return ApiResponse.failure(response.message ?? 'Failed to fetch pokemon');
    }

    try {
      final pokemon = PokemonModel.fromJson(response.data);

      return ApiResponse.success(pokemon);
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  Future<ApiResponse<PokemonModel>> getPokemonByName(String name) async {
    final response = await apiClient.get(
      PokemonEndpoints.getPokemonByName(name),
    );

    if (!response.success) {
      return ApiResponse.failure(response.message ?? 'Pokemon not found');
    }

    try {
      final pokemon = PokemonModel.fromJson(response.data);

      return ApiResponse.success(pokemon);
    } catch (e) {
      return ApiResponse.failure(e.toString());
    }
  }

  Future<List<PokemonSearchModel>> getPokemonSearchList() async {
    final response = await apiClient.get(
      PokemonEndpoints.getPokemons(limit: 2000, offset: 0),
    );

    if (!response.success) {
      return [];
    }

    final results = response.data['results'] as List;

    return results.map((pokemon) {
      return PokemonSearchModel.fromJson(pokemon);
    }).toList();
  }
}
