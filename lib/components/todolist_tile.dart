import 'package:flutter/material.dart';

class ToDoListTile extends StatelessWidget {
  final String taskString;
  final bool isChecked;
  final Function() onPressedSettings;
  final Function() onPressedDelete;
  final Function() onChanged;

  const ToDoListTile({
    super.key,
    required this.taskString,
    required this.isChecked,
    required this.onPressedSettings,
    required this.onPressedDelete,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (_) {
                    onChanged();
                  },
                  activeColor: Colors.grey[800],
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  taskString,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: onPressedSettings,
                  icon: Icon(
                    Icons.settings,
                    size: 20,
                  ),
                ),
                IconButton(
                  onPressed: onPressedDelete,
                  icon: Icon(
                    Icons.delete,
                    size: 20,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}