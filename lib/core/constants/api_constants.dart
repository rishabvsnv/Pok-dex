abstract final class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://pokeapi.co/api/v2';

  static const String pokemonEndpoint = '/pokemon';

  static const String pokemonSpeciesEndpoint = '/pokemon-species';

  static const String evolutionChainEndpoint = '/evolution-chain';

  static const int defaultLimit = 20;

  static const int maxLimit = 100;
}
