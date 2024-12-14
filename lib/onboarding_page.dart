import 'package:flutter/material.dart';

class CodeEntryPage extends StatefulWidget {
  final String title;

  const CodeEntryPage({super.key, required this.title});

  @override
  State<CodeEntryPage> createState() => _CodeEntryPageState();
}

class _CodeEntryPageState extends State<CodeEntryPage>
    with TickerProviderStateMixin {
  final TextEditingController _codeController = TextEditingController();
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0.5, end: 1.0)
        .animate(_controller.drive(CurveTween(curve: Curves.easeOutSine)));
  }

  void _navigateToNextScreen(BuildContext context) {
    final codeText = _codeController.text.trim();

    // final code = switch (codeText) {
    // // TODO: Move to general bucket
    // // General Scenarios:
    // //   'drone' => 'https://storage.googleapis.com/spls/arcade/quiz/events/drone-derby-1.json',
    // //   'ai' => 'https://storage.googleapis.com/spls/arcade/quiz/events/ai-playground-1.json',
    // //   'test-1' => 'https://storage.googleapis.com/spls/arcade/quiz/events/test-1.json',
    // //   'test-2' => 'https://storage.googleapis.com/spls/arcade/quiz/events/test-2.json',
    // //   'test-3' => 'https://storage.googleapis.com/spls/arcade/quiz/events/test-3.json',
    // //   'test-4' => 'https://storage.googleapis.com/spls/arcade/quiz/events/test-4.json',
    // // 'ai' => 'https://storage.googleapis.com/roselabs-poc-images/tutorr/test-2.json',
    // //  TODO: Handle this case.
    // //   String() => 'https://storage.googleapis.com/spls/arcade/quiz/events/drone-derby-1.json',
    //   String() => 'https://storage.googleapis.com/quizzrr-questionbank/xmas_r0.json',
    // };

    const code = "quizzrr";

    if (code.isNotEmpty) {

      // print('_navigateToNextScreen');
      // print('code: $code');
      // print('codeText: $codeText');
      // Navigate to the screen with a named route
      // Navigator.pushNamed(
      //   context,
      //   '/homeScreen',
      //   arguments: code, // Pass the URL as an argument
      Navigator.pushNamed(
          context,
          '/homeScreen',
          arguments: {
            'param1': codeText,  // Game Code
            'param2': code, // Game URL
          });
      // );
    } else {
      // Show a message if the code is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a valid code to get started!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation,
                child: Image.network(
                  // TODO: Match Name
                  'https://storage.googleapis.com/roselabs-poc-images/quizzrr_trophy_r1.png',
                  height: 350,
                ),
                builder: (context, child) => Transform.translate(
                  offset: const Offset(0, 0),
                  child: Transform.scale(
                    scale: .5 + _animation.value,
                    // angle: _animation.value,
                    child: child,
                  ),
                ),),
              // Display an image (optional, use any image you like)
              // Image.network(
              //   'https://storage.googleapis.com/roselabs-poc-images/certin-exam/certin-buddy-256.png',
              //   height: 200,
              // ),
              const SizedBox(height: 10),
              // Welcome message
              const Text(
                // TODO: Match Name
                // 'Q U I Z Z R R',
                'L E A D E R B O A R D',
                // 'A R C A D E',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Enter your game code',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              // Text(
              //   'Enter "demo" to play without a code!',
              //   style: TextStyle(
              //     fontSize: 16,
              //     color: Colors.grey[700],
              //   ),
              //   textAlign: TextAlign.center,
              // ),
              const SizedBox(height: 20),
              // Text field for code entry
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Code',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Button to navigate to the next screen
              ElevatedButton(
                onPressed: () => _navigateToNextScreen(context),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
