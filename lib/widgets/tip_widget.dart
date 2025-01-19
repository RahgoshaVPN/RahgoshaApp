import 'package:flutter/material.dart';

class TipWidget extends StatelessWidget {
  final String text;

  const TipWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return _buildTip();
  }

  Widget _buildTip() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.yellow[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb, color: Colors.white), 
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
