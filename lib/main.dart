import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:fruit_catcher/game/managers/audio_manager.dart';
import 'game/fruit_catcher_game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize audio
  await AudioManager().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Fruit Catcher Game', home: const GameScreen());
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // final ValueNotifier<int> counter = ValueNotifier(0);
  late FruitCatcherGame game;
  late ValueNotifier<int> counter;

  @override
  void initState() {
    super.initState();
    game = FruitCatcherGame();
    counter = game.scoreNotifier;
  }

  @override
  void dispose() {
    // game.onRemove();
    counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: game),
          Positioned(
            top: 50,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
              ),

              child: ValueListenableBuilder(
                valueListenable: counter,
                builder: (context, score, child) {
                  return Text(
                    "Score: $score",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ),

          Positioned(
            top: 50,
            right: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.music_note, color: Colors.black),
                  onPressed: () {
                    AudioManager().toggleMusic();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up, color: Colors.black),
                  onPressed: () {
                    AudioManager().toggleSfx();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}