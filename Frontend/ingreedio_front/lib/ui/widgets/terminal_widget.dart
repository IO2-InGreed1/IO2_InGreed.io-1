import 'package:flutter/material.dart';

class TerminalScreen extends StatefulWidget {
  const TerminalScreen({super.key});

  @override
  State<TerminalScreen> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
  final List<String> _lines = [];
  final TextEditingController _controller = TextEditingController();

  void _executeCommand(String command) {
    setState(() {
      _lines.add('> $command');
      _lines.add('Executing command...');
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _lines.add('> ');
        _controller.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            width: 500,
            child: ListView.builder(
              itemCount: _lines.length,
              itemBuilder: (context, index) {
                return Text(
                  _lines[index],
                  style: const TextStyle(color: Colors.white, fontFamily: 'Courier'),
                );
              },
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 500,
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white, fontFamily: 'Courier'),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      _executeCommand(value);
                    }
                  },
                ),
              ),
              const Text(
                '>',
                style: TextStyle(color: Colors.white, fontFamily: 'Courier'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}