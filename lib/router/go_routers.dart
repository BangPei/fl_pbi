import 'package:fl_pbi/injector/injector.dart';
import 'package:fl_pbi/injector/navigation_service.dart';
import 'package:fl_pbi/library/session_manager.dart';
import 'package:fl_pbi/main_layout/bottom_navigator.dart';
import 'package:fl_pbi/pages/pages_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final NavigationService _nav = locator<NavigationService>();
final GlobalKey<NavigatorState> _dashboardNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'dashboard');

class RouteNavigation {
  static final GoRouter router = GoRouter(
    navigatorKey: _nav.navKey,
    redirect: (context, state) async {
      String? token = await Session.get("token");
      if (token == null || token == "") {
        return '/auth';
      } else {
        return null;
      }
    },
    initialLocation: '/',
    routes: [
      GoRoute(
        parentNavigatorKey: _nav.navKey,
        path: '/auth',
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: LoginScreen(),
          );
        },
      ),
      ShellRoute(
        restorationScopeId: "",
        navigatorKey: _dashboardNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return BottomNavigation(child: child);
        },
        routes: [
          GoRoute(
            parentNavigatorKey: _dashboardNavigatorKey,
            path: '/',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: HomeScreen(),
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: _dashboardNavigatorKey,
            path: '/profile',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: ProfileScreen(),
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: _nav.navKey,
                path: 'form',
                name: "profile-form",
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                    child: ProfileForm(),
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: _nav.navKey,
                path: 'password',
                name: "change-password",
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                    child: ChangePasswordForm(),
                  );
                },
              ),
              // GoRoute(
              //   parentNavigatorKey: _nav.navKey,
              //   path: 'users',
              //   name: "users",
              //   pageBuilder: (context, state) {
              //     return const NoTransitionPage(
              //       child: UserScreen(),
              //     );
              //   },
              // ),
            ],
          ),
          GoRoute(
            path: '/surat-resmi',
            name: "surat-resmi",
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: OfficialLetterScreen(),
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: _nav.navKey,
                path: 'preview',
                name: "preview-pdf",
                pageBuilder: (context, state) {
                  var extra = state.extra as Map<String, dynamic>;
                  return NoTransitionPage(
                    child: PDFMainLayout(
                      data: extra["data"],
                      pdf: extra['pdf'],
                      fileName: extra["title"],
                    ),
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: _nav.navKey,
                path: 'surat-permohonan',
                name: "surat-permohonan",
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                    child: SuratPermohonanScreen(),
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: _nav.navKey,
                path: 'surat-lunas',
                name: "surat-lunas",
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                    child: SuratLunasScreen(),
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: _nav.navKey,
                path: 'sewa-lahan',
                name: "sewa-lahan",
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                    child: SuratSewaLahanScreen(),
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: _nav.navKey,
                path: 'formulir-pendaftaran',
                name: "formulir-pendaftaran",
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                    child: FormulirPendaftaranScreen(),
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: _nav.navKey,
                path: 'perjanjian-hak-guna',
                name: "perjanjian-hak-guna",
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                    child: PerjanjianHakGunaPakai(),
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: _nav.navKey,
                path: 'tanda-hak-guna',
                name: "tanda-hak-guna",
                pageBuilder: (context, state) {
                  return const NoTransitionPage(
                    child: TandaHakGunaScreen(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
