import 'package:flet_view/controls/error.dart';
import 'package:flutter/material.dart';

import '../models/control.dart';
import '../utils/colors.dart';
import '../utils/icons.dart';
import '../web_socket_client.dart';
import 'create_control.dart';

class FloatingActionButtonControl extends StatelessWidget {
  final Control? parent;
  final Control control;
  final List<Control> children;
  final bool parentDisabled;

  const FloatingActionButtonControl(
      {Key? key,
      this.parent,
      required this.control,
      required this.children,
      required this.parentDisabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("FloatingActionButtonControl build: ${control.id}");

    String? text = control.attrString("text");
    IconData? icon = getMaterialIcon(control.attrString("icon", "")!);
    Color? bgColor =
        HexColor.fromString(context, control.attrString("bgColor", "")!);
    var contentCtrls = children.where((c) => c.name == "content");
    bool disabled = control.isDisabled || parentDisabled;

    Function()? onPressed = disabled
        ? null
        : () {
            debugPrint("FloatingActionButtonControl ${control.id} clicked!");
            ws.pageEventFromWeb(
                eventTarget: control.id,
                eventName: "click",
                eventData: control.attrs["data"] ?? "");
          };

    if (text == null && icon == null) {
      return const ErrorControl("FAB doesn't have a text, nor icon.");
    }

    Widget button;
    if (contentCtrls.isNotEmpty) {
      button = FloatingActionButton(
          onPressed: onPressed,
          child: createControl(control, contentCtrls.first.id, disabled));
    } else if (icon != null && text == null) {
      button = FloatingActionButton(
        onPressed: onPressed,
        child: Icon(icon),
        backgroundColor: bgColor,
      );
    } else if (icon != null && text != null) {
      button = FloatingActionButton.extended(
          onPressed: onPressed,
          label: Text(text),
          icon: Icon(icon),
          backgroundColor: bgColor);
    } else {
      return const ErrorControl("FAB doesn't have a text, nor icon.");
    }

    return constrainedControl(button, parent, control);
  }
}