import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ingreedio_front/cubit_logic/session_data.dart';
import 'package:ingreedio_front/database/database_mockup.dart';
import 'package:ingreedio_front/login_screen.dart';
import 'package:ingreedio_front/ui/product_search_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'cubit_logic/session_cubit.dart';
MaterialPageRoute widgetShower(Widget child)
{
  return MaterialPageRoute(builder:(context)=>Scaffold(body: SingleChildScrollView(child: child),appBar: AppBar(),));
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => SessionCubit(SessionData.empty()),
      child: MaterialApp(
        routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => const MyHomePage(title: 'Flutter Demo Home Page',),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                onPressed: ()
                {
                  SessionCubit.fromContext(context).state.currentClient=MockupDatabase.filled().getAllClients().first;
                  SessionCubit.fromContext(context).state.currentProducer=null;
                  Navigator.push(context,widgetShower(const ProductSearchScreen()));
                }, 
                child: const Text("Client pov")),
              TextButton(
                onPressed: ()
                {
                  SessionCubit.fromContext(context).state.currentClient=null;
                  SessionCubit.fromContext(context).state.currentProducer=MockupDatabase.filled().productDatabse.getAllProducers().first;
                  Navigator.push(context,widgetShower(ProductEditScreen.fromCubit(cubit: SessionCubit.fromContext(context),)));
                },
                child: const Text("Producer pov")),
              TextButton(
                onPressed: ()
                {
                  SessionCubit.fromContext(context).state.currentClient=null;
                  SessionCubit.fromContext(context).state.currentProducer=null;
                  Navigator.push(context,widgetShower(const Text("Wsadź tu swój widget panie Piotrze")));
                }, 
                child: const Text("Admin pov")),
            ],
          )
        ),
        
      ),
    );
  }
}
