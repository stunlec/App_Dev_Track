import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation App',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Navigation App'),
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
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final rollController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    rollController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 600,
              child: Card(
                  color: Colors.white,
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Name :',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 40),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: nameController,
                              cursorHeight: 22,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("Username"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Email :',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 43),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: emailController,
                              cursorHeight: 22,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("User email"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Roll No :',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 30),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: rollController,
                              cursorHeight: 22,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("User Rollno"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Phone No :',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: phoneController,
                              cursorHeight: 22,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("User PhoneNo"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.center),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsPage(
                                          name: nameController,
                                          email: emailController,
                                          rollNo: rollController,
                                          phoneNo: phoneController,
                                        )));
                          },
                          child: Text("Show Details"))
                    ]),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage(
      {super.key,
      required this.name,
      required this.email,
      required this.rollNo,
      required this.phoneNo});

  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController rollNo;
  final TextEditingController phoneNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
          child: SizedBox(
        width: 600,
        height: 300,
        child: Card(
            elevation: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "The input details are as follows:",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                ListTile(
                  title: Text("Name: ${name.text}"),
                ),
                ListTile(
                  title: Text("Email: ${email.text}"),
                ),
                ListTile(
                  title: Text("Roll No.: ${rollNo.text}"),
                ),
                ListTile(
                  title: Text("Phone No.: ${phoneNo.text}"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Logged Out!"),
                                content: Text("User ${name.text} Logged out!"),
                              );
                            },
                          );
                        },
                        child: const Text("Go Back!"))
                  ],
                )
              ],
            )),
      )),
    );
  }
}
