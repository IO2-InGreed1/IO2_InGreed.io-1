import 'package:flutter/material.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';
import 'package:ingreedio_front/ui/screens/register_screen.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

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

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final String email = _usernameController.text;
      final String password = _passwordController.text;
      var cubit=SessionCubit.fromContext(context);
      var data=await cubit.database.loginUser(email, password);

      if (data!=null) 
      {
        cubit.setData(data);
      } 
      else 
      {
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
      appBar: getStandardAppBar(context,searchButton: true),
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
              const SizedBox(height: 20),
               ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Scaffold(
                      appBar: getStandardAppBar(context),
                      body:const RegisterPage(),
                    );
                  },));
                },
                child: const Text('Register'),
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