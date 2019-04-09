import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:learnalist/play/v1/total_recall/list_recall_v1.dart';
import 'package:learnalist/utils/shared.dart';
import 'package:learnalist/models/learnalist.dart';

class TotalRecallV1 extends StatefulWidget {
  final AlistV1 aList;

  TotalRecallV1({Key key, @required this.aList});

  @override
  State<StatefulWidget> createState() {
    return TotalRecallV1State();
  }
}

enum TotalRecallV1GameState {
  start,
  playing,
  recall,
  info,
}

class TotalRecallV1State extends State<TotalRecallV1> {
  // Items to show, current thinking is to use 7 items from the list.
  List<String> items;
  // Index within the items list.
  int index;
  // How long to display each item for. Currently in seconds.
  int howLong = 1;

  DateTime alert;
  DateTime startItem;
  DateTime start;

  TotalRecallV1GameState gameState;

  @override
  void initState() {
    super.initState();
    // TODO reduce this to 7 items.
    items = widget.aList.getItems();

    gameState = TotalRecallV1GameState.start;
  }

  void actionStartGame() {
    gameState = TotalRecallV1GameState.playing;
    reset();

    alert = DateTime.now().add(Duration(seconds: (howLong * items.length)));
  }

  void actionEndGame() {
    gameState = TotalRecallV1GameState.start;
    reset();
  }

  void actionShowInfo() {
    gameState = TotalRecallV1GameState.info;
    reset();
  }

  void reset() {
    index = -1;
    start = DateTime.now();
    startItem = DateTime.now();
  }

  void updateItemIndex() {
    var now = DateTime.now();
    var diff = now.difference(startItem);
    var diffFromStart = now.difference(start);
    print('Diff in seconds is ${diff.inSeconds}');
    print(diff);
    print(diffFromStart);
    if (diff.inSeconds >= (howLong - 1)) {
      startItem = DateTime.now();
      index++;
    }
  }

  Widget renderInfo() {
    return Text('I am info');
  }

  Widget renderMenu() {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.play_circle_outline),
              onPressed: () {
                setState(() {
                  actionStartGame();
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.stop),
              onPressed: () {
                setState(() {
                  actionEndGame();
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                setState(() {
                  actionShowInfo();
                });
              },
            ),
          ]),
    );
  }

  Widget renderItems(BuildContext context, DateTime now, bool reached) {
    return TimerBuilder.periodic(Duration(seconds: 1), alignment: Duration.zero,
        builder: (context) {
      // This function will be called every second until the alert time
      final textStyle = Theme.of(context).textTheme.title;
      updateItemIndex();

      var toShow = items[index];
      return Text(
        toShow,
        style: textStyle,
      );
    });
  }

  Widget renderTestRecall(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('What do you remember?'),
          ListRecallV1(
              actionButtonPressed: actionButtonPressed, validItems: items)
        ]);
  }

  Widget _createLayoutForInfo(BuildContext context) {
    Widget main = renderInfo();
    return _createLayout(context, main);
  }

  Widget _createLayout(BuildContext context, Widget main) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: renderMenu(),
        ),
        Expanded(
          child: Container(
            color: Colors.yellow,
            child: Center(
              child: Container(child: main),
            ),
          ),
        )
      ],
    ));
  }

  Widget _createLayoutForPlaying(BuildContext context) {
    // The code inside scheduled is self contained.
    // So the build is not always triggered, for instance
    // when setting gameState.
    return TimerBuilder.scheduled([alert], builder: (context) {
      // This function will be called once the alert time is reached
      var now = DateTime.now();
      var reached = now.compareTo(alert) >= 0;

      if (reached) {
        gameState = TotalRecallV1GameState.recall;
        return _createLayoutForRecall(context);
      }

      Widget main = renderItems(context, now, reached);
      return _createLayout(context, main);
    });
  }

  Widget _createLayoutForRecall(BuildContext context) {
    Widget main = renderTestRecall(context);
    return _createLayout(context, main);
  }

  @override
  Widget build(BuildContext context) {
    if (gameState == TotalRecallV1GameState.playing) {
      return _createLayoutForPlaying(context);
    }

    if (gameState == TotalRecallV1GameState.recall) {
      return _createLayoutForRecall(context);
    }

    // Covers start and info
    return _createLayoutForInfo(context);
  }
}
/*
String formatDuration(Duration d) {
  String f(int n) {
    return n.toString().padLeft(2, '0');
  }

  // We want to round up the remaining time to the nearest second
  d += Duration(microseconds: 999999);
  return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
}
*/

Future<void> actionButtonPressed(
    BuildContext context, GlobalKey<FormState> formKey) async {
  if (formKey.currentState.validate()) {
    print('Well done');
    notImplementedYet(context);
  }
}
