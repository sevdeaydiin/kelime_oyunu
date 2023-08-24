import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ko/screens/body2.dart';

class HexagonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final hexagonSideLength = size.width / 2;
    final hexagonCenter = Offset(size.width / 2, size.height / 2);

    final path = Path();
    for (int i = 0; i < 6; i++) {
      final radians = 2 * pi / 6 * i;
      final x = hexagonCenter.dx + hexagonSideLength * cos(radians);
      final y = hexagonCenter.dy + hexagonSideLength * sin(radians);
      if (i == 0) {
        path.moveTo(y, x);
      } else {
        path.lineTo(y, x);
      }
    }
    path.close();

    final paint = Paint()..color = Colors.white;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class HexagonContainer extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  int? previousLength;

  HexagonContainer({
    super.key,
    this.controller,
    this.focusNode,
    this.previousLength,
  });

  @override
  State<HexagonContainer> createState() => HexagonContainerState();
}

class HexagonContainerState extends State<HexagonContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.transparent,
      child: CustomPaint(
        painter: HexagonPainter(),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            autofocus: widget.controller!.text.isEmpty,
            showCursor: false,
            textCapitalization: TextCapitalization.characters,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.allow(
                  RegExp(r'[a-zA-ZğüşöçİĞÜŞÖÇ\s]')),
            ],
            onChanged: (_) {
              widget.controller!.addListener(() {
                if (widget.controller!.text.length < widget.previousLength!) {
                  widget.controller!.value = widget.controller!.value.copyWith(
                    text: widget.controller!.text
                        .substring(0, widget.controller!.text.length),
                    selection: TextSelection.collapsed(
                        offset: widget.controller!.text.length),
                  );
                }
                widget.previousLength = widget.controller!.text.length;
              });
            },
            onSubmitted: (_) {
              if (widget.controller!.text.length == 1) {
                widget.focusNode!.unfocus();
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
      ),
    );
  }
}

extension Utility on BuildContext {
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (
        FocusScope.of(this).focusedChild?.context?.widget is! EditableText);
  }
}
