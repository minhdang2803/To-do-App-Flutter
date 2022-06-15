import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/navigations/app_route.dart';
import 'package:todoapp/providers/providers.dart';
import 'package:todoapp/theme.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized;
//   runApp(
//     DevicePreview(
//       enabled: true,
//       tools: const [
//         ...DevicePreview.defaultTools,
//       ],
//       builder: (context) => const MyTodo(),
//     ),
//   );
// }
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyTodo());
}

class MyTodo extends StatefulWidget {
  const MyTodo({Key? key}) : super(key: key);

  @override
  State<MyTodo> createState() => _MyTodoState();
}

class _MyTodoState extends State<MyTodo> {
  final ThemeData theme = TodoTheme.light();

  final _listManager = ListManager();

  final _appStateManager = AppStateManager();

  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      listManager: _listManager,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _listManager),
        ChangeNotifierProvider(create: (context) => _appStateManager),
      ],
      child: Consumer<ListManager>(
        builder: ((context, value, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme,
              title: 'To Do App',
              home: Router(
                routerDelegate: _appRouter,
                backButtonDispatcher: RootBackButtonDispatcher(),
              ),
            )),
      ),
    );
  }
}
