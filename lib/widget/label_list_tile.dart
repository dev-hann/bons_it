import 'package:flutter/material.dart';
import 'package:bons_it/model/label.dart';

class LabelListTile extends StatelessWidget {
  const LabelListTile({
    super.key,
    required this.label,
    required this.onTap,
    this.trailing,
  });
  final Label label;
  final VoidCallback onTap;
  final Widget? trailing;

  Widget leadingWidget() {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Colors.white,
        ),
        color: Color(label.colorValue),
      ),
      child: const SizedBox.square(
        dimension: 40.0,
      ),
    );
  }

  Widget titleWidget() {
    return Text(label.name);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: titleWidget(),
      leading: leadingWidget(),
      trailing: trailing,
    );
  }
}
