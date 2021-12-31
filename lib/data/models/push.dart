import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Push {
  static const String ACTION_INIT = 'init';
  static const String ACTION_WANT = 'want';
  static const String DATA_BLOCKS = 'blocks';
  static const String DATA_MEMPOOL_BLOCKS = 'mempool-blocks';
  static const String DATA_LIVE_2HR_CHART = 'live-2h-chart';

  String action;
  List<String> data;

  Push({@required this.action, this.data});

  factory Push.fromJson(Map<String, dynamic> json) {
    return Push(action: json['action'], data: json['data']);
  }

  Map<String, dynamic> toJson() => {'action': action, 'data': data};

  String toJsonString() {
    return jsonEncode(this);
  }
}
