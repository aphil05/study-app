import 'package:flutter/material.dart';
import 'package:study_app/flash_card_page.dart';


// This page is for viewing all cards in a flash card set
// users can create new flash cards to add to the set
// it is responsible for getting questions and answers from users

class FlashCard {
  final String question;
  final String answer;
  FlashCard({required this.question, required this.answer});
}

class SetPage extends StatefulWidget {
  const SetPage({super.key});

  @override
  State<SetPage> createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {
  // gets user input
  final TextEditingController setQuestionController = TextEditingController();
  //
  final TextEditingController setAnswerController = TextEditingController();
  //creates a list of inputs
  final List<FlashCard> flashCardsList = [];
  bool answerBar = false;

  @override
  Widget build(BuildContext context) {
    void createNewFlashCard() {
      final String flashCardQuestion = setQuestionController.text.trim();
      final String flashCardAnswer = setAnswerController.text.trim();
      if (flashCardQuestion.isEmpty || flashCardAnswer.isEmpty) return;

      setState(() {
        flashCardsList.add(
          FlashCard(question: flashCardQuestion, answer: flashCardAnswer),
        );
      });

      setQuestionController.clear();
      setAnswerController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("set page"),
        centerTitle: true,
        backgroundColor: Colors.purple.shade800,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.purple.shade900,
          gradient: RadialGradient(
            center: const Alignment(0, -0.2),
            radius: 0.9,
            colors: [
              const Color.fromARGB(255, 232, 160, 247),
              const Color.fromARGB(255, 80, 0, 146),
            ],
            stops: const [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsGeometry.all(12),
                child: TextField(
                  controller: setQuestionController,
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelText: "Question",
                    hintText: "___ is the powerhouse of the cell",
                    hintStyle: const TextStyle(color: Colors.black54),
                  ),
                  onChanged: (value) {
                    setState(() {
                      answerBar = value.isNotEmpty;
                    });
                  },
                ),
              ),
          // creates a new flash card
          if (answerBar)
          Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: setAnswerController,
                style: const TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  labelText: "Answer",
                  hintText: "Mitochondria",
                  hintStyle: TextStyle(color: Colors.black54),
                ),
              ),
            ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: createNewFlashCard,
                    child: const Icon(Icons.add),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: flashCardsList.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FlashCardPage(
                                  flashCard: flashCardsList, // ✅ STEP 5 GOES HERE
                                ),
                              ),
                            );
                          },
                    child: const Text("test your knowledge"),
                  ),




          // navigate to flash_card_page
         /*ElevatedButton(
  onPressed: flashCardsList.isEmpty
      ? null
      : () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FlashCardPage(
                flashCard: flashCardsList,
                
              ),
            ),
          );
        },
  child: const Text("test your knowledge"),
), */
          

          // all flash cards layout
              // all flash cards layout
              Expanded(
                child: ListView.builder(
                  itemCount: flashCardsList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        flashCardsList[index].question,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: const Icon(Icons.arrow_forward, color: Colors.white),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
