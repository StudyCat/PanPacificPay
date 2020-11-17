// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';

import 'package:dragon_sword_purse/main.dart';
import 'package:dio/dio.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  test('接口测试', () async {
      BaseOptions options = BaseOptions(
        contentType : 'application/json',
        receiveDataWhenStatusError: false
     );
     Dio dio = Dio(options);
     String url = 'http://192.168.1.120:8030/' + 'tldUser/registerTldUser';
     CancelToken cancelToken = CancelToken();
    Response response = await dio.post(url,queryParameters:Map<String, dynamic>.from({}),cancelToken: cancelToken);     
    Map responseMap = response.data;
    // Map responseMap = jsonDecode(jsonString);
    List data = responseMap['data'];
    final dataList = [];
    expect(data, dataList);
  });
}
