import 'package:flutter/material.dart';
import 'package:ingreedio_front/assets.dart';
import 'package:ingreedio_front/creators/creators.dart';
import 'package:ingreedio_front/creators/product_creator.dart';
import 'package:ingreedio_front/login_screen.dart';
import 'package:ingreedio_front/products.dart';void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
      '/': (context) => LoginPage(),
      '/home': (context) => const MyHomePage(title: 'Flutter Demo Home Page',),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  List<Product> products=List.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Assets.resizedInGreedIcon(),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            DialogButton<Product>(creator: ProductCreator(reference: ItemWrapper(Product.empty()),), onFinished: (val){
              setState(() {
                products.add(val);
              });
            }, child:const Text("XD")),
          ...products.map((e) => e.iconWidget).toList()
          ],
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
