// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// import 'package:learnalist/main.dart';
import 'package:learnalist/models/alist.dart';

void main() {
  test('Test list basic', () {
    final Alist b = Alist.fromJson(exampleListV1);
    print(b);
    print(b.uuid);
    print(b.listInfo.listType);
  });
  test('Test list v1', () {
    final AlistV1 b = newAlistV1(Alist.fromJson(exampleListV1));
    print(b);
    print(b.uuid);
    print(b.listInfo.listType);
    print(b.listData[0]);
  });

  test('Test list v2', () {
    final AlistV2 b = newAlistV2(Alist.fromJson(exampleListV2));
    print(b);
    print(b.uuid);
    print(b.listInfo.listType);
    print(b.listData[0]);
    print(b.listData[0].from);
    print(b.listData[0].to);
  });

  test('Test getList', () {
    List<Alist> lists = getLists();
    print(lists);
  });

  test('Set of lists', () {
    Set<Alist> setOfLists = Set();
    List<Alist> lists = getLists();
    lists.forEach((aList) {
      setOfLists.add(aList);
    });
    lists.forEach((aList) {
      setOfLists.add(aList);
    });
    print(setOfLists.length);
  });
}
