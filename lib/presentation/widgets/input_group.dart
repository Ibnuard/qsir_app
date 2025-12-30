import 'package:flutter/material.dart';
import 'package:qsir_app/presentation/widgets/custom_input.dart';

class InputGroupItem {
  final String key;
  final String? label;
  final bool isPassword;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget Function(BuildContext context, TextEditingController controller)?
  customBuilder;
  final VoidCallback? onTap;
  final bool readOnly;

  InputGroupItem({
    required this.key,
    this.label,
    this.isPassword = false,
    this.decoration,
    this.keyboardType,
    this.validator,
    this.customBuilder,
    this.onTap,
    this.readOnly = false,
  });
}

class InputGroupController {
  final Map<String, TextEditingController> _controllers = {};

  TextEditingController getController(String key) {
    if (!_controllers.containsKey(key)) {
      _controllers[key] = TextEditingController();
    }
    return _controllers[key]!;
  }

  String getText(String key) {
    return _controllers[key]?.text ?? '';
  }

  void setText(String key, String value) {
    getController(key).text = value;
  }

  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
  }
}

class InputGroup extends StatefulWidget {
  final List<InputGroupItem> items;
  final InputGroupController? controller;
  final Function(String key, String value)? onChanged;

  const InputGroup({
    super.key,
    required this.items,
    this.controller,
    this.onChanged,
  });

  @override
  State<InputGroup> createState() => _InputGroupState();
}

class _InputGroupState extends State<InputGroup> {
  late InputGroupController _controller;
  final Map<String, FocusNode> _focusNodes = {};

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? InputGroupController();
    for (var item in widget.items) {
      _focusNodes[item.key] = FocusNode();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    for (var node in _focusNodes.values) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.items.length, (index) {
        final item = widget.items[index];
        final isLast = index == widget.items.length - 1;

        if (item.customBuilder != null) {
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 16.0),
            child: item.customBuilder!(
              context,
              _controller.getController(item.key),
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : 16.0),
          child: CustomInput(
            key: ValueKey(item.key),
            label: item.label,
            isPassword: item.isPassword,
            controller: _controller.getController(item.key),
            focusNode: _focusNodes[item.key],
            decoration: item.decoration,
            keyboardType: item.keyboardType,
            readOnly: item.readOnly,
            onTap: item.onTap,
            textInputAction: isLast
                ? TextInputAction.done
                : TextInputAction.next,
            onSubmitted: (_) {
              if (!isLast) {
                final nextKey = widget.items[index + 1].key;
                _focusNodes[nextKey]?.requestFocus();
              }
            },
            onChanged: (value) {
              widget.onChanged?.call(item.key, value);
            },
          ),
        );
      }),
    );
  }
}
