import 'package:flutter/material.dart';
import 'package:study_app/set_page.dart';

// user can see all sets on this page
// user can create new set on this page
// only input needed is the name of the new set

class FlashCardSet {
  final String name;
  FlashCardSet({required this.name});
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // gets user input
  final TextEditingController setNameController = TextEditingController();
  //creates a list of inputs
  final List<FlashCardSet> sets = [];

  void createNewSet() {
    final String setName = setNameController.text.trim();
    if (setName.isEmpty) return;
    setState(() {
      sets.add(FlashCardSet(name: setName));
    });
    setNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // creates a new set of flash cards

    /* TextField(
      controller: setNameController,
      decoration: const InputDecoration(
        labelText: "Name your set",
        hintText: "e.g. Biology Chapter 1",
      ),
    ); 
    */

    /* go back and study */

    return Scaffold(
      appBar: AppBar(
        title: const Text("home page"),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
              const SizedBox(height: 12),

              // Create new set - white background
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: setNameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Name your set",
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: createNewSet,
                      child: const Text("Create"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Existing sets list - centered rectangular black cards
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  itemCount: sets.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SetPage()),
                          );
                        },
                        child: Container(
                          width: 340,
                          height: 84,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 10,
                                offset: const Offset(0, 6),
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                sets[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Icon(Icons.arrow_forward, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
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

  @override
  void dispose() {
    setNameController.dispose();
    super.dispose();
  }
}

