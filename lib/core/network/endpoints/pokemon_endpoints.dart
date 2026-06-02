import 'package:pokedex/core/constants/api_constants.dart';

abstract final class PokemonEndpoints {
  PokemonEndpoints._();

  static String getPokemons({
    int limit = ApiConstants.defaultLimit,
    int offset = 0,
  }) {
    return '${ApiConstants.pokemonEndpoint}?limit=$limit&offset=$offset';
  }

  static String getPokemonByName(String name) {
    return '${ApiConstants.pokemonEndpoint}/$name';
  }

  static String getPokemonById(int id) {
    return '${ApiConstants.pokemonEndpoint}/$id';
  }

  static String getPokemonSpecies(int id) {
    return '${ApiConstants.pokemonSpeciesEndpoint}/$id';
  }

  static String getEvolutionChain(int id) {
    return '${ApiConstants.evolutionChainEndpoint}/$id';
  }
}
