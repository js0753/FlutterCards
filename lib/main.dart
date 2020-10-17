import 'package:flutter/material.dart';
import 'dart:math';
//import 'dart:async';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
    backgroundColor: Colors.green,
    body: CardGame(),
  )));
}

class CardGame extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _CardGameState createState() => _CardGameState();
}

class _CardGameState extends State<CardGame> {
  List<Widget> tableCards;
  List playerCards;
  List cardList;
  List tableList;
  List checkList;
  List betList;
  List foldList;
  int finalRound;
  int roundNo;
  int betFlag;
  int foldFlag;
  int checkFlag;
  int currency1;
  int currency0;
  int betAmount;
  Widget restart1;
  var logText;
  var resText;
  void check(int playerId) {
    if (betFlag != 1 && foldFlag != 1) {
      checkFlag = 1;
      nextRound();
    }
  }

  void bet(int x) {
    if (foldFlag != 1 && checkFlag != 1) {
      if (x == 1) {
        currency1 -= (roundNo + 1) * 50;
      } else {
        currency0 -= (roundNo + 1) * 50;
      }
      betAmount += (roundNo + 1) * 50;
      if (x == 1) {
        betFlag = 1;
        nextRound();
      }
    }
  }

  void fold(int pid) {
    if (betFlag != 1 && checkFlag != 1) {
      foldFlag = 1;
      //Timer(Duration(seconds: 1), () {
      updateLog("Game Over\nYou Loose");
      //});
      restart1 = FlatButton(
          onPressed: () => setState(() {
                init();
              }),
          color: Colors.white,
          child: Text("Restart"));
      updateResult("You Folded .Opponent Wins");
    }
  }

  List deck;

  Image createCard(var card) {
    return Image.asset(
      "images/$card.png",
      height: 75,
      width: 45,
      fit: BoxFit.fitWidth,
    );
  }

  List addCard(List cardImages, List cardList) {
    var card;
    int index = Random().nextInt(deck.length);
    card = 'deck/' + deck[index];
    cardList.add(deck[index]);
    cardImages.add(createCard(card));
    deck.removeAt(index);
    return cardList;
  }

  List getEnemyCard() {
    if (roundNo >= finalRound + 1) {
      return playerCards[0];
    } else {
      List<Widget> temp = [];
      for (int i = 0; i < playerCards[0].length; i++) {
        temp.add(createCard('red_back'));
      }
      return temp;
    }
  }

  void init() {
    deck = [
      'AC',
      '2C',
      '3C',
      '4C',
      '5C',
      '6C',
      '7C',
      '8C',
      '9C',
      '10C',
      'JC',
      'QC',
      'KC',
      'AD',
      '2D',
      '3D',
      '4D',
      '5D',
      '6D',
      '7D',
      '8D',
      '9D',
      '10D',
      'JD',
      'QD',
      'KD',
      'AH',
      '2H',
      '3H',
      '4H',
      '5H',
      '6H',
      '7H',
      '8H',
      '9H',
      '10H',
      'JH',
      'QH',
      'KH',
      'AS',
      '2S',
      '3S',
      '4S',
      '5S',
      '6S',
      '7S',
      '8S',
      '9S',
      '10S',
      'JS',
      'QS',
      'KS'
    ];
    tableCards = [];
    playerCards = [];
    cardList = [];
    tableList = [];
    checkList = [];
    betList = [];
    foldList = [];
    int players = 2;
    roundNo = 1;
    finalRound = 4;
    currency1 = 59950;
    currency0 = 59950;
    betAmount = 100;
    betFlag = 0;
    foldFlag = 0;
    checkFlag = 0;
    restart1 = null;
    logText = "Round $roundNo\nYour Turn";
    resText = "";
    addCard(tableCards, tableList);
    addCard(tableCards, tableList);
    addCard(tableCards, tableList);
    for (int i = 0; i < players; i++) {
      List<Widget> temp = [];
      List t2 = [];
      playerCards.add(temp);
      cardList.add(t2);
    }
    for (int i = 0; i < playerCards.length; i++) {
      addCard(playerCards[i], cardList[i]);
      addCard(playerCards[i], cardList[i]);
    }
  }

  void updateLog(var text1) {
    /*
    var timer = (new DateTime.now()).millisecondsSinceEpoch / 1000;
    while (true) {
      var ms = (new DateTime.now()).millisecondsSinceEpoch / 1000;
      if (ms - timer >= 0.5) break;
    }
    */
    setState(() {
      logText = text1;
    });
  }

  void updateResult(string1) {
    setState(() {
      resText = string1;
    });
  }

  String determineWinner() {
    List cardCount = [];
    for (int index = 0; index < cardList.length; index++) {
      List temp = [];
      for (int k = 0; k < 13; k++) temp.add(0);
      cardCount.add(temp);
      for (int i = 0; i < cardList[index].length; i++) {
        if (cardList[index][i][0] == 'A') {
          cardCount[index][0] += 1;
        } else if (cardList[index][i][0] == 'K') {
          cardCount[index][1] += 1;
        } else if (cardList[index][i][0] == 'Q') {
          cardCount[index][2] += 1;
        } else if (cardList[index][i][0] == 'J') {
          cardCount[index][3] += 1;
        } else if (cardList[index][i][0] == '1') {
          cardCount[index][4] += 1;
        } else if (cardList[index][i][0] == '9') {
          cardCount[index][5] += 1;
        } else if (cardList[index][i][0] == '8') {
          cardCount[index][6] += 1;
        } else if (cardList[index][i][0] == '7') {
          cardCount[index][7] += 1;
        } else if (cardList[index][i][0] == '6') {
          cardCount[index][8] += 1;
        } else if (cardList[index][i][0] == '5') {
          cardCount[index][9] += 1;
        } else if (cardList[index][i][0] == '4') {
          cardCount[index][10] += 1;
        } else if (cardList[index][i][0] == '3') {
          cardCount[index][11] += 1;
        } else if (cardList[index][i][0] == '2') {
          cardCount[index][12] += 1;
        } else {
          cardCount[index][13] += 1;
        }
      }
    }

    restart1 = FlatButton(
        onPressed: () => setState(() {
              init();
            }),
        color: Colors.white,
        child: Text("Restart"));

    for (int i = 0; i < 13; i++) {
      if (cardCount[1][i] > cardCount[0][i]) {
        updateResult("You Win by upper Hand ");
        return "You Win";
      } else if (cardCount[1][i] < cardCount[0][i]) {
        updateResult("Opponent Wins by upper Hand ");
        return "You Loose";
      } else {
        continue;
      }
    }
    updateResult("Tie");
    return "It's a Tie";
  }

  void nextRound() {
    if (roundNo < finalRound) {
      if (betFlag == 1) {
        updateLog("Round $roundNo\nOpponent Bets\nYour Turn");
        betFlag = 0;
        bet(0);
      } else if (checkFlag == 1) {
        updateLog("Round $roundNo\nOpponent Checks\nYour Turn");
        checkFlag = 0;
      }
      roundNo++;
      //Timer(Duration(seconds: 1), () {
      //updateLog("Round $roundNo\nYour Turn");
      //});

      setState(() {
        addCard(tableCards, tableList);
        addCard(playerCards[0], cardList[0]);
        addCard(playerCards[1], cardList[0]);
      });
      checkFlag = 0;
      foldFlag = 0;
    } else {
      roundNo++;
      var result = determineWinner();
      updateLog("Game Over\n$result");
    }
  }

  _CardGameState() {
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Currency\nRs.$currency1"),
            Text(logText),
            Text("Bet\nRs.$betAmount")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: getEnemyCard(),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: tableCards,
          ),
        ),
        Text(
          resText,
          style: TextStyle(color: Colors.yellow),
        ),
        Container(
          child: restart1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(
              color: Colors.white,
              child: Text("Check"),
              onPressed: () {
                check(1);
              },
            ),
            FlatButton(
              color: Colors.white,
              child: Text("Bet"),
              onPressed: () {
                bet(1);
              },
            ),
            FlatButton(
              color: Colors.white,
              child: Text("Fold"),
              onPressed: () {
                fold(1);
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: playerCards[1],
        ),
      ],
    );
  }
}
