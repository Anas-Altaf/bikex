import 'package:flutter/material.dart';

enum SheetContent { none, first, second }

class TestScreen extends StatefulWidget {
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  SheetContent _content = SheetContent.none;
  final DraggableScrollableController _controller =
      DraggableScrollableController();

  void _expandWith(SheetContent content) {
    setState(() => _content = content);
    _controller.animateTo(
      0.6,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Main Screen')),

      bottomSheet: DraggableScrollableSheet(
        controller: _controller,
        minChildSize: 0.12,
        initialChildSize: 0.12,
        maxChildSize: 0.6,
        snap: true,
        snapSizes: const [0.12, 0.6],

        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [BoxShadow(blurRadius: 10)],
            ),
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              children: [
                _grabHandle(),

                if (_content == SheetContent.none) ...[
                  ElevatedButton(
                    onPressed: () => _expandWith(SheetContent.first),
                    child: const Text('Show First Content'),
                  ),
                  ElevatedButton(
                    onPressed: () => _expandWith(SheetContent.second),
                    child: const Text('Show Second Content'),
                  ),
                ],

                if (_content == SheetContent.first)
                  const Text('First content goes here'),

                if (_content == SheetContent.second)
                  const Text('Second content goes here'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _grabHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
