import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App with MYSQL',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> senddata() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.post(
        Uri.parse("http://localhost/insertdata1.php"),
        body: {
          "username": usernameController.text,
          "password": passwordController.text,
        },
      );
      if (response.statusCode == 200) {
        print("User data inserted successfully");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User registered successfully')),
        );
      } else {
        print("Error: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
    } catch (e) {
      print('Error sending data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending data: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Username",
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(hintText: 'Username'),
              ),
              const SizedBox(height: 20),
              const Text(
                "Password",
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                controller: passwordController,
                obscureText: true, // Hide password text
                decoration: const InputDecoration(hintText: 'Password'),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator() // Show loading indicator when sending data
                  : ElevatedButton(
                      child: const Text("Register"),
                      onPressed: () {
                        if (usernameController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill in all fields')),
                          );
                        } else {
                          senddata();
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
