import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kai/pages/home_page.dart';
import 'package:kai/pages/loading_page.dart';
import 'package:kai/router/transition_route_builders.dart';

part 'app_router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    RedirectRoute(path: '/home-page', redirectTo: '/'),
    CustomRoute(
      page: LoadingPage,
      initial: true,
      customRouteBuilder: slideTransitionRouteBuilder,
    ),
    CustomRoute(
      page: HomePage,
      customRouteBuilder: slideTransitionRouteBuilder,
    ),
  ],
)
class AppRouter extends _$AppRouter {}
