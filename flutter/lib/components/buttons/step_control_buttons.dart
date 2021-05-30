import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/common/theme_color.dart';

class StepControlButtons extends HookWidget {
  const StepControlButtons({this.back, this.next, this.disabled});
  final Function back;
  final Function next;
  final disabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ElevatedButton(
            onPressed: back,
            child: const Text('前へ'),
            style: ElevatedButton.styleFrom(primary: ThemeColor.primary),
          ),
          ElevatedButton(
            onPressed: disabled ? null : next,
            child: const Text('次へ'),
            style: disabled
                ? ElevatedButton.styleFrom(primary: Colors.grey[400])
                : ElevatedButton.styleFrom(primary: ThemeColor.primary),
          ),
        ],
      ),
    );
  }
}
