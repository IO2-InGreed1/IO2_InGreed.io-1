import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ingreedio_front/cubit_logic/cubit_consumer.dart';
import 'package:ingreedio_front/cubit_logic/ingredient_cubit.dart';
import 'package:ingreedio_front/cubit_logic/preference_cubit.dart';
import 'package:ingreedio_front/cubit_logic/session_data.dart';
import 'package:ingreedio_front/ui/admin_screen.dart';
import 'package:ingreedio_front/ui/client_screen.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import 'package:ingreedio_front/ui/moderator_screen.dart';
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
      child: BlocProvider(
        create: (BuildContext context)=>IngredientCubit.empty()..loadIngredients(context),
        child: BlocProvider(
          create: (_)=>PreferenceCubit.empty(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
            '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page',),
            },
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor:const Color.fromARGB(255, 10, 255, 92),secondary: Colors.yellow[100]),
              useMaterial3: true,
              scaffoldBackgroundColor:const Color.fromARGB(255, 247, 236, 153),
            ),
          
          ),
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
class RoleSelectionWidget extends StatelessWidget {
  const RoleSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //return const LoginPage();
    return Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                onPressed: () async
                {
                  var cubit=SessionCubit.fromContext(context);
                  SessionData? data=await SessionCubit.fromContext(context).database.loginUser("client", "client");
                  if(data==null) return;
                  cubit.setData(data);
                }, 
                child: const Text("Client pov")),
              TextButton(
                onPressed: () async
                {
                  var cubit=SessionCubit.fromContext(context);
                  SessionData? data=await SessionCubit.fromContext(context).database.loginUser("producer", "producer");
                  if(data==null) return;
                  cubit.setData(data);
                },
                child: const Text("Producer pov")),
              TextButton(
                onPressed: () async
                {
                  var cubit=SessionCubit.fromContext(context);
                  SessionData? data=await SessionCubit.fromContext(context).database.loginUser("admin", "admin");
                  if(data==null) return;
                  cubit.setData(data);
                }, 
                child: const Text("Admin pov")),
                TextButton(
                onPressed: () async
                {
                  var cubit=SessionCubit.fromContext(context);
                  SessionData? data=await SessionCubit.fromContext(context).database.loginUser("moderator", "moderator");
                  if(data==null) return;
                  cubit.setData(data);
                }, 
                child: const Text("Moderator pov")),
            ],
          )
        ),
        
      );
  }
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SessionDataConsumer(child: (context,data)
      {
        if(data.currentClient!=null) {
          return ClientScreen(client:data.currentClient!);
        }
        if(data.currentProducer!=null) {
          return addLogoutButton(ProductEditScreen(producer: data.currentProducer!));
        }
        if(data.currentModerator!=null) 
        {
          return ModeratorScreen(moderator:data.currentModerator!);                           
        }
        if(data.currentAdmin!=null) 
        {
          return AdminScreen(admin:data.currentAdmin!);
        }
        return const RoleSelectionWidget();
      })
    );
  }
}
Widget addLogoutButton(Widget child)
{
  return SingleChildScrollView(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoutButton(),
            child
          ],
        ));
}
