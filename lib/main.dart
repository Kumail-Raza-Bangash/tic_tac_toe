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
              if (provider.checkWinner()) {
                _showWinnerDialog(context);
              }
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

  void _showWinnerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Player ${Provider.of<TicTacToeProvider>(context).isPlayerOneTurn ? 'X' : 'O'} wins!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Provider.of<TicTacToeProvider>(context, listen: false).restartGame();
                Navigator.of(context).pop();
              },
              child: Text('Restart'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('Home'),
            ),
          ],
        );
      },
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
      notifyListeners();
    }
  }

  bool checkWinner() {
    // Implement your winning conditions and return true if a player wins.
    // For simplicity, I'm returning true after every move.
    return true;
  }

  void restartGame() {
    board = List.filled(9, '');
    isPlayerOneTurn = true;
    notifyListeners();
  }
}
