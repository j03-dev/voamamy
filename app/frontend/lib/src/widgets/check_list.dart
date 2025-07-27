import 'package:flutter/material.dart';

enum Status { Checked, Pedding }

class CheckList extends StatelessWidget {
  final String leftItem;
  final String rightItem;
  final Status status;

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
        Container(
          child: Row(
            spacing: 5,
            children: [
              Container(
                child: Icon(Icons.check, color: Colors.white, size: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color:
                      status == Status.Checked
                          ? Theme.of(context).primaryColor
                          : Colors.amber,
                ),
                padding: EdgeInsets.all(2.0),
              ),
              Text(leftItem, style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
        Text(rightItem, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
