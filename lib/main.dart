import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mempool_flutter_frontend/widgets/block.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'data/models/mempool_block.dart';
import 'data/models/push.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Test(),
    );
  }
}

class Test extends StatefulWidget {
  const Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://mempool.space/api/v1/ws'),
  );

  @override
  void initState() {
    channel.sink.add('{"action":"init"}');
    String push = jsonEncode(
            Push(action: Push.ACTION_WANT, data: [Push.DATA_MEMPOOL_BLOCKS]))
        .toString();

    channel.sink.add(push);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
              stream: channel.stream,
              builder: (ctx, snapshot) {
                if (snapshot.hasData) {
                  final Map<String, dynamic> data = jsonDecode(snapshot.data);

                  List<MempoolBlockModel> blocks = data['mempool-blocks']
                      .map<MempoolBlockModel>(
                          (json) => MempoolBlockModel.fromJson(json))
                      .toList();

                  return ListView.builder(
                      itemCount: blocks.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Align(
                              alignment: Alignment.center,
                              child: BlockWidget(block: blocks[index])),
                        );
                      });
                } else {
                  return Text("No data");
                }
              }),
        ),
      ),
    );
  }
}
