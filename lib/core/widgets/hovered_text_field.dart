import 'package:flutter/material.dart';

class HoveredTextField extends StatefulWidget {
  final TextField textField;
  final Color hoveredBorder;

  const HoveredTextField(
      {super.key, required this.textField, required this.hoveredBorder});

  @override
  State<HoveredTextField> createState() => _HoveredTextFieldState();
}

class _HoveredTextFieldState extends State<HoveredTextField> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color borderColor = widget.textField.decoration?.border?.borderSide.color ??
        Theme.of(context).dividerColor;

    InputBorder border = const UnderlineInputBorder();

    if (widget.textField.decoration?.border != null) {
      border = widget.textField.decoration?.enabledBorder ?? border;
    }

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: Builder(
        builder: (context) {
          return TextField(
            controller: widget.textField.controller,
            focusNode: widget.textField.focusNode,
            decoration: widget.textField.decoration?.copyWith(
              enabledBorder: border.copyWith(
                borderSide: BorderSide(
                  color: isHovered ? widget.hoveredBorder : borderColor,
                ),
              ),
              focusedBorder: widget.textField.decoration?.focusedBorder,
            ),
            keyboardType: widget.textField.keyboardType,
            maxLines: widget.textField.maxLines,
            style: widget.textField.style,
          );
        },
      ),
    );
  }
}
