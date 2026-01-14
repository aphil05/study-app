import 'package:flutter/material.dart';
import 'package:study_app/set_page.dart';
import 'dart:math' as math;

// This page shows flash cards and includes a flip animation
class FlashCardPage extends StatefulWidget {
  final List<FlashCard> flashCard; // receive data
  const FlashCardPage({
    super.key,
    required this.flashCard,
  });

  @override
  State<FlashCardPage> createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFlip() {
    if (_controller.isAnimating) return;
    if (_controller.isDismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void nextCard() {
    setState(() {
      if (currentIndex < widget.flashCard.length - 1) {
        currentIndex++;
      }
      _controller.reverse();
    });
  }

  void previousCard() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
      _controller.reverse();
    });
  }

  Widget _buildCardContent(bool front) {
    final card = widget.flashCard[currentIndex];
    final text = front ? card.question : card.answer;
    return Container(
      width: 300,
      height: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flash card page"),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _toggleFlip,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final angle = _controller.value * math.pi;
                    final isFront = angle <= math.pi / 2;
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(angle),
                      child: isFront
                          ? _buildCardContent(true)
                          : Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..rotateY(math.pi),
                              child: _buildCardContent(false),
                            ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: currentIndex > 0 ? previousCard : null,
                    child: const Text("Previous"),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: currentIndex < widget.flashCard.length - 1
                        ? nextCard
                        : null,
                    child: const Text("Next"),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Text(
                "${currentIndex + 1} / ${widget.flashCard.length}",
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
