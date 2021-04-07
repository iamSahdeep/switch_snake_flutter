import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switch_snake/GameNotifier.dart';
import 'package:switch_snake/HelperClasses.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Switch Snake',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
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
        final double itemHeight =
            (size.height - kToolbarHeight - 24) / notifier.board[0].length;
        final double itemWidth = size.width / notifier.board[0].length;
        return RawKeyboardListener(
          focusNode: _focusNode,
          autofocus: true,
          onKey: notifier.handleKeyPress,
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Score : ${notifier.snake.snakePartList.length - 1}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Center(
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: notifier.board[0].length,
                                    childAspectRatio: (itemWidth / itemHeight)),
                            shrinkWrap: true,
                            itemCount: notifier.board[0].length *
                                notifier.board[0].length,
                            itemBuilder: (context, index) {
                              int x =
                                  (index % notifier.board[0].length).toInt();
                              int y = index ~/ notifier.board[0].length;
                              Cell cell = notifier.board[x][y];
                              return CupertinoSwitch(
                                  value: cell.cellType != CellType.EMPTY,
                                  onChanged: (_) {});
                            }),
                      ),
                    ],
                  ),
                ),
                notifier.gamesOver
                    ? Center(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Score : ${notifier.snake.snakePartList.length - 1}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MaterialButton(
                                    onPressed: () {
                                      notifier.init();
                                    },
                                    child: Text("Restart"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
        );
      }),
    ); //Scaffold
  }
}
