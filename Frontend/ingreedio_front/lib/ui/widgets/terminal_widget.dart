import 'package:flutter/material.dart';
import 'dart:async';

class TerminalScreen extends StatefulWidget {
  const TerminalScreen({super.key});

  @override
  State<TerminalScreen> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
  final List<String> _lines = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showPrompt = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startFlickering();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _startFlickering() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _showPrompt = !_showPrompt;
      });
    });
  }

  void _executeCommand(String command) {
    setState(() {
      _lines.add('> $command');
      _lines.add('Executing command...');
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _controller.clear();
      });
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
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
            width: 510,
            child: ListView.builder(
              controller: _scrollController,
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
              _showPrompt?const Text(
                '>',
                style: TextStyle(color: Colors.white, fontFamily: 'Courier'),
              ):const SizedBox(width: 10,),
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
            ],
          ),
        ],
      ),
    );
  }
}