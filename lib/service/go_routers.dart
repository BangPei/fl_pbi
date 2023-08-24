import 'package:fl_pbi/main_layout/parent_layout.dart';
import 'package:fl_pbi/screen/dashboard_screen.dart';
import 'package:fl_pbi/screen/login_screen.dart';
import 'package:fl_pbi/screen/official_letter/formulir_pendaftaran/formulir_pendaftaran_pdf.dart';
import 'package:fl_pbi/screen/official_letter/formulir_pendaftaran/formulir_pendaftaran_screen.dart';
import 'package:fl_pbi/screen/official_letter/formulir_pendaftaran/pendaftaran.dart';
import 'package:fl_pbi/screen/official_letter/surat_lunas/lunas.dart';
import 'package:fl_pbi/screen/official_letter/surat_lunas/surat_lunas_pdf.dart';
import 'package:fl_pbi/screen/official_letter/surat_lunas/surat_lunas_screen.dart';
import 'package:fl_pbi/screen/official_letter/surat_permohonan/permohonan.dart';
import 'package:fl_pbi/screen/official_letter/surat_permohonan/surat_permohonan_screen.dart';
import 'package:fl_pbi/screen/official_letter/surat_permohonan/surat_permohonan_pdf.dart';
import 'package:fl_pbi/screen/official_letter/surat_sewa_lahan/sewa_lahan.dart';
import 'package:fl_pbi/screen/official_letter/surat_sewa_lahan/surat_sewa_lahan_pdf.dart';
import 'package:fl_pbi/screen/official_letter/surat_sewa_lahan/surat_sewa_lahan_screen.dart';
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
                name: "preview-permohonan",
                pageBuilder: (context, state) {
                  SuratPermohonan? data = SuratPermohonan();
                  data.name = state.uri.queryParameters['name'];
                  data.address = state.uri.queryParameters['address'];
                  data.nik = state.uri.queryParameters['nik'];
                  data.phone = state.uri.queryParameters['phone'];
                  return NoTransitionPage(
                    child: SuratPermohonanPDF(data: data),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            parentNavigatorKey: _officialLeterKey,
            path: '/surat-lunas',
            name: "surat-lunas",
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: SuratLunasScreen(),
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: _officialLeterKey,
                path: 'preview',
                name: "preview-lunas",
                pageBuilder: (context, state) {
                  SuratLunas? data = state.extra != null
                      ? state.extra as SuratLunas
                      : SuratLunas();
                  return NoTransitionPage(
                    child: SuratLunasPDF(data: data),
                  );
                },
              ),
            ],
          ),
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
          ),
          GoRoute(
            parentNavigatorKey: _officialLeterKey,
            path: '/sewa-lahan',
            name: "sewa-lahan",
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: SuratSewaLahanScreen(),
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: _officialLeterKey,
                path: 'preview',
                name: "preview-lahan",
                pageBuilder: (context, state) {
                  SuratSewaLahan? data = state.extra != null
                      ? state.extra as SuratSewaLahan
                      : SuratSewaLahan();
                  return NoTransitionPage(
                    child: SuratSewaLahanPDF(data: data),
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
