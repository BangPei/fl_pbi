import 'package:flutter/material.dart';

class ButtonInOut extends StatefulWidget {
  final Function(int) onTap;
  const ButtonInOut({super.key, required this.onTap});

  @override
  State<ButtonInOut> createState() => _ButtonInOutState();
}

class _ButtonInOutState extends State<ButtonInOut> {
  Color color = Colors.white;
  int index = 0;
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
                    "Uang Masuk",
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
                    "Uang Keluar",
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
