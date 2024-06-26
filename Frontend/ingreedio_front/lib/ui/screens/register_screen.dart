import 'package:flutter/material.dart';
import 'package:ingreedio_front/cubit_logic/session_cubit.dart';
import 'package:ingreedio_front/database/databse.dart';
import 'package:ingreedio_front/ui/common_ui_elements.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordRepeatController;
  late TextEditingController _emailController;
  late GlobalKey<FormState> _formKey;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordRepeatController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      final String username = _usernameController.text;
      final String email = _emailController.text;
      final String password = _passwordController.text;
      var cubit=SessionCubit.fromContext(context);
      var data=await cubit.database.loginDatabase.register(username,email, password,UserRole.client);
      if (data!=null) 
      {
        // cubit.state.userToken=data;
        // cubit.refreshUser();
        cubit.loginUser(email, password);
      } 
      else 
      {
        setState(() {
          _errorMessage = 'register error';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 236, 228, 156),
      appBar: getStandardAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
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
                  const int minLength=5;
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if(value.length<minLength) return "password must be at least $minLength characters long";
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordRepeatController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Repeat password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty|| value!=_passwordController.text) {
                    return 'Please repeat your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
               ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
                onPressed: _register,
                child: const Text('Register'),
              ),
              const SizedBox(height: 20),
               ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
                onPressed: (){
                  SessionCubit.fromContext(context).reset();
                },
                child: const Text('Return to login'),
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