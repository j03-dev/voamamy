import 'package:flutter/material.dart';

class CheckList extends StatelessWidget {
  final String leftItem;
  final String rightItem;
  final bool status;

  const CheckList({
    super.key,
    required this.leftItem,
    required this.rightItem,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 5,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color:
                    status == true
                        ? Theme.of(context).primaryColor
                        : Colors.amber,
              ),
              padding: EdgeInsets.all(2.0),
              child: Icon(Icons.check, color: Colors.white, size: 16),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Text(
                leftItem,
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Text(rightItem, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
