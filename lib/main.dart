import 'package:demo/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: Techradar(),
    );
  }
}

class Techradar extends StatefulWidget {
  const Techradar({super.key});

  @override
  State<Techradar> createState() => _TechradarState();
}

class _TechradarState extends State<Techradar> {
  List<UserModel> userList = [];
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final response = await _dio.get('https://api.escuelajs.co/api/v1/users');
    if (response.statusCode == 200) {
      List<UserModel> data = response.data.map<UserModel>((e) => UserModel.fromJson(e)).toList();
      setState(() {
        userList = data;
      });
    }
  }

  void clear() {
    setState(() {
      userList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Techradar'),
        leading: Lottie.network('https://lottie.host/12668702-7119-458b-9494-75b2e5a6469f/cdqhxNmM7M.json', repeat: false),
        actions: [
          IconButton(
              onPressed: () {
                getData();
              },
              icon: const Icon(Icons.search))
        ],
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ContainerLearn(),
            //const SizedBox(height: 20),
            //const ImageLearn(),
            //const SizedBox(height: 20),
            //ListViewLearn(),
            SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        userList[index].avatar!,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                      title: Text(userList[index].name!),
                      subtitle: Text(userList[index].email!),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          clear();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListViewLearn extends StatelessWidget {
  const ListViewLearn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: User.dummyData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.blue,
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(User.dummyData[index].name),
              subtitle: Text(User.dummyData[index].surName),
            ),
          );
        },
      ),
    );
  }
}

class ImageLearn extends StatelessWidget {
  const ImageLearn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        height: 300,
        child: Image.network(
          'https://picsum.photosw/200/300',
          errorBuilder: (context, error, stackTrace) => const Center(
            child: CircularProgressIndicator(
              value: 0.1,
            ),
          ),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  value: 100,
                ),
              );
            }
          },
          fit: BoxFit.contain,
        ));
  }
}

class ContainerLearn extends StatelessWidget {
  const ContainerLearn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            height: 200,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
            child: const Center(child: Text('1')),
          ),
          const SizedBox(width: 10),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
            child: const Center(child: Text('2')),
          ),
        ],
      ),
    );
  }
}

class User {
  String name;
  String surName;

  User({required this.name, required this.surName});

  static List<User> dummyData = [
    User(name: 'John', surName: 'Doe'),
    User(name: 'Jane', surName: 'Doe'),
    User(name: 'John', surName: 'Doe'),
    User(name: 'Jane', surName: 'Doe'),
  ];
}
