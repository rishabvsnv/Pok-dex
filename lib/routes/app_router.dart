import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/home/presentation/pages/home_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',

    routes: [
      GoRoute(
        path: '/',
        builder: (_, _) => const HomePage()
      ),
      GoRoute(
        path: '/home',
        builder: (_, _) => const HomePage()
      ),
    ]
  );
});