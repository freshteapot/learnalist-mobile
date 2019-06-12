import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:learnalist/play/V2/total_recall/list_recall_v2.dart';
import 'package:learnalist/models/alist.dart';

class TotalRecallV2 extends StatefulWidget {
  final AlistV2 aList;

  TotalRecallV2({Key key, @required this.aList});

  @override
  State<StatefulWidget> createState() {
    return TotalRecallV2State();
  }
}

enum TotalRecallV2GameState {
  start,
  playing,
  recall,
  info,
  history,
  finished,
}

class TotalRecallV2State extends State<TotalRecallV2> {
  // Items to show, current thinking is to use 7 items from the list.

  List<String> items;
  // Index within the items list.
  int index;
  // How long to display each item for. Currently in seconds.
  int howLong = 1;

  DateTime alert;
  DateTime startItem;

  TotalRecallV2GameState gameState;

  @override
  void initState() {
    super.initState();

    gameState = TotalRecallV2GameState.start;
  }

  void actionStartGame() {
    var _items = widget.aList.getItems();
    _items.removeWhere((item) => item.from == item.to);

    items = _items.map((item) {
      return item.to;
    }).toList();

    var size = items.length >= 7 ? 7 : items.length;

    items = (items..shuffle()).sublist(0, size);
    gameState = TotalRecallV2GameState.playing;
    reset();

    alert = DateTime.now().add(Duration(seconds: (howLong * items.length)));
  }

  void actionEndGame() {
    gameState = TotalRecallV2GameState.start;
    reset();
  }

  void actionShowInfo() {
    gameState = TotalRecallV2GameState.info;
    reset();
  }

  void actionShowHistory() {
    gameState = TotalRecallV2GameState.history;
    reset();
  }

  void actionShowRecall() {
    gameState = TotalRecallV2GameState.recall;
    reset();
  }

  void reset() {
    index = -1;
    startItem = DateTime.now();
  }

  void updateItemIndex() {
    var now = DateTime.now();
    var diff = now.difference(startItem);

    print('Diff in seconds is ${diff.inSeconds}');
    print(diff);

    if (diff.inSeconds >= (howLong - 1)) {
      startItem = DateTime.now();
      index++;
    }
  }

  Widget renderInfo() {
    return Text(
      'Welcome, its total recall time!\nClick the play button\n7 items will be picked at random.\nHow many can you remember?',
    );
  }

  Widget renderMenu() {
    var buttons = <Widget>[
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
    ];

    if (gameState == TotalRecallV2GameState.recall) {
      buttons.add(IconButton(
        icon: Icon(Icons.remove_red_eye),
        onPressed: () {
          setState(() {
            actionShowHistory();
          });
        },
      ));
    }

    if (gameState == TotalRecallV2GameState.history) {
      buttons.add(IconButton(
        icon: Icon(Icons.remove_red_eye),
        onPressed: () {
          setState(() {
            actionShowRecall();
          });
        },
      ));
    }

    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: buttons,
    ));
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
    return ListRecallV2(
        actionButtonPressed: actionButtonPressed, validItems: items);
  }

  Widget renderTestHistory(BuildContext context) {
    return ListHistoryV2(aList: widget.aList, items: items);
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
        gameState = TotalRecallV2GameState.recall;
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

  Widget _createLayoutForHistory(BuildContext context) {
    Widget main = renderTestHistory(context);
    return _createLayout(context, main);
  }

  Widget _createLayoutForFinished(BuildContext context) {
    Widget main = Text(
      'Well done, you remembered all the items,\n hit the play button to play again.',
      textAlign: TextAlign.left,
    );

    return _createLayout(context, main);
  }

  Future<void> actionButtonPressed(
      BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState.validate()) {
      setState(() => gameState = TotalRecallV2GameState.finished);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (gameState == TotalRecallV2GameState.playing) {
      return _createLayoutForPlaying(context);
    }

    if (gameState == TotalRecallV2GameState.recall) {
      return _createLayoutForRecall(context);
    }

    if (gameState == TotalRecallV2GameState.history) {
      return _createLayoutForHistory(context);
    }

    if (gameState == TotalRecallV2GameState.finished) {
      return _createLayoutForFinished(context);
    }

    // Covers start and info
    return _createLayoutForInfo(context);
  }
}

class ListHistoryV2 extends StatelessWidget {
  final AlistV2 aList;
  final List<String> items;

  ListHistoryV2({Key key, @required this.aList, @required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData localTheme = Theme.of(context);
    return ListView.builder(
      padding: const EdgeInsets.only(left: 32.0),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item =
            aList.getItems().firstWhere((item) => item.to == items[index]);
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            '${item.to}',
            style: localTheme.textTheme.body2,
          ),
          subtitle: Text(
            '${item.from}',
            style: localTheme.textTheme.body1.copyWith(color: Colors.grey),
          ),
        );
      },
    );
  }
}
