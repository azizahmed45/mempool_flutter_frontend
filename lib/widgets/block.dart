import 'package:flutter/material.dart';
import 'package:mempool_flutter_frontend/data/models/mempool_block.dart';

class BlockWidget extends StatelessWidget {
  final MempoolBlockModel block;

  const BlockWidget({@required this.block, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(color: Colors.blue),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${block.blockSizeInMb.toStringAsFixed(2)} MB',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            '${block.numberOfTransaction} transactions',
            style: TextStyle(color: Colors.white, fontSize: 12),
          )
        ],
      ),
    );
  }
}
