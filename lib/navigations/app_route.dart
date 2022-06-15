import 'package:flutter/material.dart';
import 'package:todoapp/components/todo_path.dart';
import 'package:todoapp/providers/providers.dart';
import 'package:todoapp/screens/screens.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  GlobalKey<NavigatorState> navigatorKey;
  final AppStateManager appStateManager;
  final ListManager listManager;

  AppRouter({required this.appStateManager, required this.listManager})
      : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    listManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    super.dispose();
    appStateManager.removeListener(notifyListeners);
    listManager.removeListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handleOnPop,
      pages: [
        //TODO SplashScreen
        if (!appStateManager.isSplashScreen) SplashScreen.page(),
        //TODO OnboardingScreen
        if (appStateManager.isSplashScreen &&
            appStateManager.isOnboardingScreen == false)
          OnboardingScreen.page(),
        //TODO: Goto HomePage
        if (appStateManager.isOnboardingScreen) Homepage.page(),
        // //TODO: Goto NoteScreen
        // if (appStateManager.isOnNoteScreen) NoteScreen.page()
      ],
    );
  }

  bool _handleOnPop(Route<dynamic> route, value) {
    if (!route.didPop(value)) {
      return false;
    }
    if (route.settings.name == TodoPages.onboardingPath) {
      appStateManager.logout();
    }
    // if (route.settings.name == TodoPages.item) {
    //   appStateManager.gotoNoteScreen(false);
    // }
    return true;
  }

  @override
  // ignore: avoid_returning_null_for_void
  Future<void> setNewRoutePath(configuration) async => null;
}
