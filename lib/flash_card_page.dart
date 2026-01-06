import 'package:flutter/material.dart';
import 'package:study_app/set_page.dart';

// This page is used to display flash cards
// Users will interact with it by swiping and tapping
// Nothing new will be created on this page

class FlashCardPage extends StatefulWidget {
  final List<FlashCard> flashCard; //receive data
  const FlashCardPage({
    super.key,
    required this.flashCard, //responsible for set page error
  });

  @override
  State<FlashCardPage> createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage> {
  int currentIndex = 0;
  bool showAnswer = false;

  void nextCard() {
    setState(() {
      showAnswer = false;
      if (currentIndex < widget.flashCard.length - 1) {
        currentIndex++;
      }
    });
  }

void previousCard() {
    setState(() {
      showAnswer = false;
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
final card = widget.flashCard[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text("flash card page")),

      body: Column(
        children: [GestureDetector(
          onTap: () {
            setState(() {
              showAnswer = !showAnswer;
            });
          },

          child: Container(
            width: 250,
            height: 250,
            alignment: Alignment.center,
            color: Colors.grey,
            child: Text(
              showAnswer
                  ? widget.flashCard[currentIndex].answer
                  : widget.flashCard[currentIndex].question,
            ),
          ),
        ), 
        const SizedBox(height: 20),
        /// 🔹 NEXT / PREVIOUS BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: currentIndex > 0 ? previousCard : null,
                child: const Text("Previous"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: currentIndex < widget.flashCard.length - 1
                    ? nextCard
                    : null,
                child: const Text("Next"),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// 🔹 CARD COUNTER
          Text(
            "${currentIndex + 1} / ${widget.flashCard.length}",
            style: const TextStyle(color: Colors.grey),
          ),
        ] 
      ),
    );
  }
}
