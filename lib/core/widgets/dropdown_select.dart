import 'package:flutter/material.dart';

class DropdownSelect<T> extends StatefulWidget {
  void _onChanged(dynamic value) {
    if (onChanged != null) {
      onChanged!(value as T);
    }
  }

  final List<T> values;
  final T? defaultVariant;
  final Function(T)? onChanged;
  const DropdownSelect(
      {super.key, required this.values, this.defaultVariant, this.onChanged});

  @override
  State<DropdownSelect> createState() => _DropdownSelectState<T>();
}

class _DropdownSelectState<T> extends State<DropdownSelect> {
  T? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: dropdownValue ?? widget.defaultVariant,
        style: TextStyle(color: Colors.grey[600]),
        dropdownColor: Colors.grey[900],
        focusColor: Colors.transparent,
        items: widget.values
            .map((entry) => DropdownMenuItem(
                  value: entry,
                  child: Text(
                    entry.toString().toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            if (value != null) {
              dropdownValue = value as T?;
            }
          });
          if (value != null) {
            widget._onChanged(value);
          }
        });
  }
}
