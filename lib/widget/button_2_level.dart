import 'package:flutter/material.dart';

class Button2Level extends StatefulWidget {
  final int? initIndex;
  final String label1;
  final String label2;
  final Function(int) onTap;
  const Button2Level({
    super.key,
    required this.onTap,
    required this.label1,
    required this.label2,
    this.initIndex,
  });

  @override
  State<Button2Level> createState() => _Button2LevelState();
}

class _Button2LevelState extends State<Button2Level> {
  Color color = Colors.white;
  int index = 0;
  @override
  void initState() {
    if (widget.initIndex != null) {
      index = widget.initIndex!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 18,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                index = 0;
                setState(() {});
                widget.onTap(index);
              },
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: index == 0
                      ? const Color.fromARGB(255, 98, 155, 248)
                      : color,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 216, 216, 216),
                      spreadRadius: 0.2,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    widget.label1,
                    style: TextStyle(
                      color: index == 0 ? Colors.white : null,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: GestureDetector(
              onTap: () {
                index = 1;
                setState(() {});
                widget.onTap(index);
              },
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: index == 1
                      ? const Color.fromARGB(255, 98, 155, 248)
                      : color,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 216, 216, 216),
                      spreadRadius: 0.2,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    widget.label2,
                    style: TextStyle(
                      color: index == 1 ? Colors.white : null,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
