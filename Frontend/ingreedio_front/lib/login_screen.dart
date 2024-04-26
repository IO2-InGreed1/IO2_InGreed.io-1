import 'package:flutter/material.dart';
import 'package:ingreedio_front/logic/users.dart';

class LoginPage extends StatefulWidget {
  final List<Client> users=[
    Client.fromAllData( id: 1,
    isBlocked: false,
    mail: 'bob@gmail.com',
    password: '123456',
    username: 'bob', 
    favoriteProducts: List.empty()),
    Client.fromAllData( id: 2,
    isBlocked: false,
    mail: 'joe@gmail.com',
    password: '123456',
    username: 'joe', 
    favoriteProducts: List.empty()),
    Client.fromAllData( id: 3,
    isBlocked: false,
    mail: 'bob@gmail.com',
    password: '',
    username: '', 
    favoriteProducts: List.empty()),
  ];

  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKey;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      final String username = _usernameController.text;
      final String password = _passwordController.text;

      bool isAuthenticated = false;
      for (var user in widget.users) {
        if (user.username == username && user.password == password) {
          isAuthenticated = true;
          break;
        }
      }

      if (isAuthenticated) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _errorMessage = 'Invalid username or password';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 236, 228, 156),
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color.fromARGB(255, 255, 239, 96),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  return null;
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  return null;
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
               ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
                onPressed: _login,
                child: const Text('Login'),
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}