import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switch_snake/GameNotifier.dart';

import 'Cell.dart';
import 'Cell.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameNotifier>(
      create: (BuildContext context) {
        return GameNotifier();
      },
      child:
          Consumer(builder: (BuildContext context, GameNotifier notifier, _) {
        final size = MediaQuery.of(context).size;
        final double itemHeight = (size.height - kToolbarHeight - 24) / notifier.board[0].length;
        final double itemWidth = size.width / notifier.board[0].length;
        return RawKeyboardListener(
          focusNode: _focusNode,
          autofocus: true,
          onKey: notifier.handleKeyPress,
          child: Scaffold(
            body: Container(
              child: Center(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: notifier.board[0].length, childAspectRatio: (itemWidth/ itemHeight)),
                    shrinkWrap: true,
                    itemCount:
                        notifier.board[0].length * notifier.board[0].length,
                    itemBuilder: (context, index) {
                      int x = (index % notifier.board[0].length).toInt();
                      int y = index ~/ notifier.board[0].length;
                      Cell cell = notifier.board[x][y];
                      return CupertinoSwitch(
                          value: cell.cellType != CellType.EMPTY,
                          onChanged: (_) {});
                    }),
              ),
            ),
          ),
        );
      }),
    ); //Scaffold
  }
}
