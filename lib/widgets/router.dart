import 'package:donor/const/disclaimer.dart';
import 'package:donor/pages/app_scaffold/app_scaffold.dart';
import 'package:donor/pages/auth/forgot_password/forgot_password.dart';
import 'package:donor/pages/auth/signin/signin.dart';
import 'package:donor/pages/auth/signup/signup.dart';
import 'package:donor/pages/requests/requests.dart';
import 'package:donor/pages/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const WelcomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'create',
          builder: (BuildContext context, GoRouterState state) {
            return SignUp();
          },
        ),
        GoRoute(
          path: 'signin',
          builder: (BuildContext context, GoRouterState state) {
            return SignIn();
          },
        ),
        GoRoute(
          path: 'forgot_password',
          builder: (BuildContext context, GoRouterState state) {
            return ForgotPassword();
          },
        ),
        GoRoute(
          path: 'app_scaffold',
          builder: (BuildContext context, GoRouterState state) {
            return AppScaffold();
          },
        ),
        GoRoute(
          path: 'disclaimer',
          builder: (BuildContext context, GoRouterState state) {
            return Disclaimer();
          },
        ),
        GoRoute(
          path: 'requests',
          builder: (BuildContext context, GoRouterState state) {
            return RequestsPage();
          },
        ),
      ],
    ),
  ],
);
