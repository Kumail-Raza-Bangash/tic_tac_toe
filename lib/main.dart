import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TicTacToeProvider(),
      child: MaterialApp(
        title: 'Tic Tac Toe',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TicTacToeScreen(),
      ),
    );
  }
}

class TicTacToeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TicTacToeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              provider.makeMove(index);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Center(
                child: Text(
                  provider.board[index],
                  style: TextStyle(
                    fontSize: 48,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TicTacToeProvider with ChangeNotifier {
  List<String> board = List.filled(9, '');
  bool isPlayerOneTurn = true;

  void makeMove(int index) {
    if (board[index] == '') {
      board[index] = isPlayerOneTurn ? 'X' : 'O';
      isPlayerOneTurn = !isPlayerOneTurn;
      checkWinner();
      notifyListeners();
    }
  }

  void checkWinner() {
    // Check for winning conditions
  }
}
