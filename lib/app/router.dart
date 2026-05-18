import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/database/app_database.dart';
import '../features/bovinos/presentation/screens/bovino_form_screen.dart';
import '../features/bovinos/presentation/screens/bovinos_list_screen.dart';
import '../features/duenos/presentation/screens/dueno_form_screen.dart';
import '../features/duenos/presentation/screens/duenos_list_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const BovinosListScreen(),
    ),
    GoRoute(
      path: '/bovinos/new',
      builder: (_, __) => const BovinoFormScreen(),
    ),
    GoRoute(
      path: '/bovinos/:id',
      builder: (context, state) {
        final bovino = state.extra as Bovino?;
        return BovinoFormScreen(bovino: bovino);
      },
    ),
    GoRoute(
      path: '/duenos',
      builder: (_, __) => const DuenosListScreen(),
    ),
    GoRoute(
      path: '/duenos/new',
      builder: (_, __) => const DuenoFormScreen(),
    ),
    GoRoute(
      path: '/duenos/:id',
      builder: (context, state) {
        final dueno = state.extra as Dueno?;
        return DuenoFormScreen(dueno: dueno);
      },
    ),
  ],
);
