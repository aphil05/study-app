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
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.all(12),
            child: TextField(
              controller: setNameController,
              decoration: InputDecoration(
                labelText: "Name your set",
                hintText: "name",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: createNewSet,
            child: const Text("create new set"),
          ),
 Container(
decoration: BoxDecoration(
  image: DecorationImage(
    image: AssetImage('images/purple aura background.jpg'),
    fit: BoxFit.cover,),
),
),

          Expanded(
            child: ListView.builder(
              itemCount: sets.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(sets[index].name),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // later: navigate to flash_card_page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SetPage()),
                    );
                  },
                );
              },
            ),
           ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    setNameController.dispose();
    super.dispose();
  }
}

