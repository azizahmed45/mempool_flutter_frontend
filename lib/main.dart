import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
    channel.sink
        .add('{"action": "want","data": ["blocks","stats","mempool-blocks"]}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
            stream: channel.stream,
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                final Map<String, dynamic> data = jsonDecode(snapshot.data);

                List<MempoolBlockModel> blocks = data['mempool-blocks']
                    .map<MempoolBlockModel>(
                        (json) => MempoolBlockModel.fromJson(json))
                    .toList();

                return Block(
                    block: MempoolBlockModel(blockSize: blocks[0].blockSize));
              } else {
                return Text("No data");
              }
            }),
      ),
    );
  }
}

class Block extends StatelessWidget {
  final MempoolBlockModel block;

  const Block({@required this.block, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(color: Colors.blue),
      child: Column(
        children: [Text(block.blockSize.toString())],
      ),
    );
  }
}

class MempoolBlockModel {
  int blockSize;

  MempoolBlockModel({this.blockSize});

  factory MempoolBlockModel.fromJson(Map<String, dynamic> json) {
    return MempoolBlockModel(blockSize: json['blockSize']);
  }
}
