import 'package:go_router/go_router.dart';
import '../core/database/app_database.dart';
import '../core/database/models/bovino_with_dueno.dart';
import '../features/bovinos/presentation/screens/bovino_detail_screen.dart';
import '../features/bovinos/presentation/screens/bovino_form_screen.dart';
import '../features/bovinos/presentation/screens/bovinos_list_screen.dart';
import '../features/duenos/presentation/screens/dueno_form_screen.dart';
import '../features/duenos/presentation/screens/duenos_list_screen.dart';
import '../features/lotes/presentation/screens/lote_form_screen.dart';
import '../features/lotes/presentation/screens/lotes_list_screen.dart';

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
      path: '/bovinos/:id/detail',
      builder: (context, state) {
        final item = state.extra as BovinoWithDueno;
        return BovinoDetailScreen(item: item);
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
    GoRoute(
      path: '/lotes',
      builder: (_, __) => const LotesListScreen(),
    ),
    GoRoute(
      path: '/lotes/new',
      builder: (_, __) => const LoteFormScreen(),
    ),
    GoRoute(
      path: '/lotes/:id',
      builder: (context, state) {
        final lote = state.extra as Lote?;
        return LoteFormScreen(lote: lote);
      },
    ),
  ],
);
