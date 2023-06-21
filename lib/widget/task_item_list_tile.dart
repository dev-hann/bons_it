import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:bons_it/model/todo_item.dart';

class TaskItemListTile extends StatelessWidget {
  const TaskItemListTile({
    super.key,
    required this.index,
    required this.taskItem,
    required this.onTap,
    required this.onTapDelete,
    required this.onTapCheck,
  });
  final int index;
  final TodoItem taskItem;
  final VoidCallback onTap;
  final VoidCallback onTapDelete;
  final VoidCallback onTapCheck;

  TextStyle get statusStyle {
    return TextStyle(
      decorationColor: Colors.white,
      decorationStyle: TextDecorationStyle.solid,
      decorationThickness: 1.0,
      decoration: taskItem.isCompleted
          ? TextDecoration.lineThrough
          : TextDecoration.none,
    );
  }

  Widget titleWidget() {
    return Text(
      taskItem.title,
      style: statusStyle,
    );
  }

  Widget subTitleWidget() {
    return Text(
      taskItem.dateTime.toIso8601String(),
      style: statusStyle,
    );
  }

  Widget trailingWidget() {
    return Checkbox(
      value: taskItem.isCompleted,
      onChanged: (value) {
        onTapCheck();
      },
    );
  }

  Widget leadingWidget() {
    return const Icon(Icons.drag_handle);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      groupTag: "TodoSlidable",
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              onTapDelete();
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        title: titleWidget(),
        leading: DragStartListener(
          index: index,
          child: leadingWidget(),
        ),
        subtitle: subTitleWidget(),
        trailing: trailingWidget(),
      ),
    );
  }
}

class DragStartListener extends ReorderableDelayedDragStartListener {
  const DragStartListener({
    super.key,
    required super.child,
    required super.index,
  });
  @override
  MultiDragGestureRecognizer createRecognizer() {
    return DelayedMultiDragGestureRecognizer(
      debugOwner: this,
      delay: const Duration(milliseconds: 100),
    );
  }
}
