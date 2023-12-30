import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Album>> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> data = jsonDecode(response.body);
    List<Album> albums = data.map((json) => Album.fromJson(json)).toList();
    return albums;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<Album> createAlbum(int userId, int id, String title) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // print("Album created");
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title,
      } =>
        Album(
          userId: userId,
          id: id,
          title: title,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Album>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  void refreshAlbumList() {
    setState(() {
      futureAlbum = fetchAlbum();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Album Data',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: const Text('Album Data'),
        ),
        body: Center(
          child: FutureBuilder<List<Album>>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Album album = snapshot.data![index];
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.album),
                          title: Text(album.title),
                          subtitle: Text("ID: ${album.id}"),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                futureAlbum = Future.value(
                                    List.from(snapshot.data!)..removeAt(index));
                              });
                            },
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _dialogBuilder(context, refreshAlbumList);
          },
          tooltip: "Add Album",
        ),
      ),
    );
  }
}

Future<void> _dialogBuilder(
    BuildContext context, VoidCallback refreshCallback) async {
  final TextEditingController userId = TextEditingController();
  final TextEditingController id = TextEditingController();
  final TextEditingController title = TextEditingController();

  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Album"),
          content: Container(
            height: 200,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Text("User ID : "),
                    SizedBox(
                      width: 200,
                      child: TextField(
                          controller: userId,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "User ID",
                          )),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text("ID : "),
                    SizedBox(width: 34),
                    SizedBox(
                      width: 200,
                      child: TextField(
                          controller: id,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Album ID",
                          )),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Text("Title : "),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 200,
                      child: TextField(
                          controller: title,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Album title",
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  await createAlbum(
                      int.parse(userId.text), int.parse(id.text), title.text);
                  Navigator.pop(context);

                  refreshCallback();
                } catch (e) {
                  print("Error creating album: $e");
                }
              },
              child: const Text("Submit"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            )
          ],
        );
      });
}
