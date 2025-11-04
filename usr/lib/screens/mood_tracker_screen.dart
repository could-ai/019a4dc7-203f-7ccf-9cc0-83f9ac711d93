import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/mood_model.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  final TextEditingController _noteController = TextEditingController();
  String? _selectedEmotion;

  final List<Map<String, dynamic>> _emotions = [
    {'name': 'Happy', 'icon': Icons.sentiment_very_satisfied, 'color': Colors.yellow},
    {'name': 'Sad', 'icon': Icons.sentiment_dissatisfied, 'color': Colors.blue},
    {'name': 'Anxious', 'icon': Icons.sentiment_neutral, 'color': Colors.orange},
    {'name': 'Calm', 'icon': Icons.sentiment_satisfied, 'color': Colors.green},
    {'name': 'Angry', 'icon': Icons.sentiment_very_dissatisfied, 'color': Colors.red},
    {'name': 'Confused', 'icon': Icons.help_outline, 'color': Colors.purple},
  ];

  void _submitMood() {
    if (_selectedEmotion != null) {
      context.read<MoodModel>().addMood(_selectedEmotion!, _noteController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mood logged successfully!')),
      );
      _noteController.clear();
      setState(() {
        _selectedEmotion = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'How are you feeling right now?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
            ),
            itemCount: _emotions.length,
            itemBuilder: (context, index) {
              final emotion = _emotions[index];
              return GestureDetector(
                onTap: () => setState(() => _selectedEmotion = emotion['name']),
                child: Card(
                  color: _selectedEmotion == emotion['name'] ? emotion['color'].withOpacity(0.3) : null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(emotion['icon'], size: 40, color: emotion['color']),
                      const SizedBox(height: 8),
                      Text(emotion['name']),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _noteController,
            decoration: const InputDecoration(
              labelText: 'Add a note (optional)',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitMood,
            child: const Text('Log Mood'),
          ),
        ],
      ),
    );
  }
}