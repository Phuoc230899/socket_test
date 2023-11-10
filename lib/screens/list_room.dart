import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_test/providers/home.dart';
import 'package:socket_test/screens/home.dart';

class ListRoomPage extends StatefulWidget {
  const ListRoomPage({super.key, required this.username});

  final String username;

  @override
  State<ListRoomPage> createState() => _ListRoomPageState();
}

class _ListRoomPageState extends State<ListRoomPage> {
  List room = [1, 2, 3, 4, 5];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Room')),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
              children: room.map((e) {
            return Column(children: [
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (context) => HomeProvider(),
                      child: HomeScreen(
                        username: widget.username,
                        roomID: e.toString(),
                      ),
                    ),
                  ),
                ),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.red,
                  child: Center(child: Text(e.toString())),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ]);
          }).toList()),
        ),
      ),
    );
  }
}
