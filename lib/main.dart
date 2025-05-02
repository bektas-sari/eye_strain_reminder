import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const EyeStrainApp());
}

class EyeStrainApp extends StatelessWidget {
  const EyeStrainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eye Strain Reminder',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const EyeStrainHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EyeStrainHomePage extends StatefulWidget {
  const EyeStrainHomePage({super.key});

  @override
  State<EyeStrainHomePage> createState() => _EyeStrainHomePageState();
}

class _EyeStrainHomePageState extends State<EyeStrainHomePage> {
  Timer? _reminderTimer;
  bool isRunning = false;

  void _startTimer() {
    _reminderTimer?.cancel();
    _reminderTimer = Timer.periodic(const Duration(minutes: 20), (timer) {
      _showReminderDialog();
    });

    setState(() {
      isRunning = true;
    });
  }

  void _stopTimer() {
    _reminderTimer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void _showReminderDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Time to rest your eyes!"),
        content: const Text("Look at something 20 feet away for 20 seconds."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _reminderTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eye Strain Reminder'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.visibility,
              size: 100,
              color: isRunning ? Colors.indigo : Colors.grey,
            ),
            const SizedBox(height: 30),
            Text(
              isRunning
                  ? "Reminder is running.\nYou'll be notified every 20 minutes."
                  : "Press Start to begin 20-20-20 reminders.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: isRunning ? _stopTimer : _startTimer,
              icon: Icon(isRunning ? Icons.stop : Icons.play_arrow),
              label: Text(isRunning ? 'Stop Reminder' : 'Start Reminder'),
              style: ElevatedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
