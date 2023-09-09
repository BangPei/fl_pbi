import 'package:fl_pbi/injector/injector.dart';
import 'package:fl_pbi/injector/navigation_service.dart';
import 'package:fl_pbi/library/session_manager.dart';
import 'package:fl_pbi/main_layout/bottom_navigator.dart';
import 'package:fl_pbi/screen/home/home_screen.dart';
import 'package:fl_pbi/screen/login/login_screen.dart';
import 'package:fl_pbi/screen/official_letter/formulir_pendaftaran/formulir_pendaftaran_pdf.dart';
import 'package:fl_pbi/screen/official_letter/formulir_pendaftaran/formulir_pendaftaran_screen.dart';
import 'package:fl_pbi/screen/official_letter/formulir_pendaftaran/pendaftaran.dart';
import 'package:fl_pbi/screen/official_letter/surat_lunas/surat_lunas_screen.dart';
import 'package:fl_pbi/screen/official_letter/surat_permohonan/surat_permohonan_screen.dart';

import 'package:fl_pbi/screen/official_letter/surat_sewa_lahan/surat_sewa_lahan_screen.dart';
import 'package:fl_pbi/screen/official_letter2.dart/official_letter_screen.dart';
import 'package:fl_pbi/screen/official_letter2.dart/official_pdf_main_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final NavigationService _nav = locator<NavigationService>();
final GlobalKey<NavigatorState> _dashboardNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'dashboard');
final GlobalKey<NavigatorState> _officialLeterKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

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
            ],
          ),
        ],
      ),
      ShellRoute(
        restorationScopeId: "",
        navigatorKey: _officialLeterKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return Scaffold(appBar: AppBar(), body: child);
        },
        routes: [
          GoRoute(
            parentNavigatorKey: _officialLeterKey,
            path: '/formulir-pendaftaran',
            name: "formulir-pendaftaran",
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: FormulirPendaftaranScreen(),
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: _officialLeterKey,
                path: 'preview',
                name: "preview-pendaftaran",
                pageBuilder: (context, state) {
                  Pendaftaran? data = state.extra != null
                      ? state.extra as Pendaftaran
                      : Pendaftaran();
                  return NoTransitionPage(
                    child: FormulirPendaftaranPDF(data: data),
                  );
                },
              ),
            ],
          )
        ],
      ),
    ],
  );
}
