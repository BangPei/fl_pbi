import 'package:fl_pbi/main_layout/parent_layout.dart';
import 'package:fl_pbi/screen/dashboard_screen.dart';
import 'package:fl_pbi/screen/login_screen.dart';
import 'package:fl_pbi/screen/official_letter/permohonan.dart';
import 'package:fl_pbi/screen/official_letter/surat_permohonan.dart';
import 'package:fl_pbi/screen/official_letter/surat_permohonan_pdf.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'injector.dart';
import 'navigation_service.dart';

final NavigationService _nav = locator<NavigationService>();
final GlobalKey<NavigatorState> _dashboardNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'dashboard');
final GlobalKey<NavigatorState> _officialLeterKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class RouteNavigation {
  static final GoRouter router = GoRouter(
    navigatorKey: _nav.navKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        // parentNavigatorKey: _dashboardNavigatorKey,
        path: '/auth',
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: LoginScreen(),
          );
        },
      ),
      ShellRoute(
        restorationScopeId: "",
        navigatorKey: _dashboardNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return ParentLayout(
            menu: "dashboard",
            child: child,
          );
        },
        routes: [
          GoRoute(
            parentNavigatorKey: _dashboardNavigatorKey,
            path: '/',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: DashboardScreen(),
              );
            },
          ),
        ],
      ),
      ShellRoute(
        restorationScopeId: "",
        navigatorKey: _officialLeterKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return ParentLayout(
            menu: "Surat Resmi",
            child: child,
          );
        },
        routes: [
          GoRoute(
              parentNavigatorKey: _officialLeterKey,
              path: '/surat-permohonan',
              name: "surat-permohonan",
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: SuratPermohonanScreen(),
                );
              },
              routes: [
                GoRoute(
                  parentNavigatorKey: _officialLeterKey,
                  path: 'preview',
                  name: "preview",
                  pageBuilder: (context, state) {
                    SuratPermohonan? data = state.extra != null
                        ? state.extra as SuratPermohonan
                        : SuratPermohonan();
                    return NoTransitionPage(
                      child: SuratPermohonanPDF(data: data),
                    );
                  },
                ),
              ]),
          // GoRoute(
          //   parentNavigatorKey: _warehouseNavigatorKey,
          //   path: '/warehouse/form',
          //   name: "add-warehouse",
          //   pageBuilder: (context, state) {
          //     return const NoTransitionPage(
          //       child: WarehouseFormScreen(),
          //     );
          //   },
          // ),
          // GoRoute(
          //   parentNavigatorKey: _warehouseNavigatorKey,
          //   path: '/warehouse/form/:id',
          //   name: "edit-warehouse",
          //   pageBuilder: (context, state) {
          //     return NoTransitionPage(
          //       child: WarehouseFormScreen(
          //         warehouseId: int.parse(state.pathParameters['id']!),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    ],
  );
}
