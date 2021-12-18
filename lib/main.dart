import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kai/router/route_observer.dart';
import 'package:kai/services/locator_service.dart';
import 'package:kai/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appRouter = locator<AppRouter>();
    return MaterialApp.router(
      routerDelegate: AutoRouterDelegate(
        _appRouter,
        navigatorObservers: () => [AppRouteObserver()],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
      title: 'Kai',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
