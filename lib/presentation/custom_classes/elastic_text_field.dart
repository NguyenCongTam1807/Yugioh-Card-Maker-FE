import 'dart:math';

import 'package:flutter/material.dart';

class ElasticTextField extends StatefulWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final Function(String) onEditingComplete;
  final TextStyle style;
  final int maxLines;
  final TextAlign textAlign;
  final InputDecoration decoration;

  const ElasticTextField(
      {required this.width,
      required this.height,
      required this.controller,
      required this.onEditingComplete,
      required this.style,
      this.decoration = const InputDecoration(border: InputBorder.none),
      this.maxLines = 1,
      this.textAlign = TextAlign.left,
      Key? key})
      : super(key: key);

  @override
  State<ElasticTextField> createState() => _ElasticTextFieldState();
}

class _ElasticTextFieldState extends State<ElasticTextField> {
  late double _textWidth;
  int _textLines = 0;
  bool _isEditable = false;
  double _textScaleY = 0.0;


  double _textWidthInOneLine(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: double.infinity);

    return textPainter.width;
  }

  int _textLinesBoundByWidget(String text, TextStyle style, double widgetWidth) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: widgetWidth);

    return textPainter.computeLineMetrics().length;
  }

  Alignment _scaleAlignment(int maxLines) {
    if (maxLines == 1) {
      return Alignment.centerLeft;
    } else {
      return Alignment.topLeft;
    }
  }

  void _scaleDownTextField(String text) {
    setState(() {
      if (widget.maxLines == 1) {
        _textWidth = _textWidthInOneLine(text, widget.style);
        _textScaleY = _textWidth / widget.width;
      } else {
        _textLines = _textLinesBoundByWidget(text, widget.style, widget.width);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isEditable
        ? TextField(
            controller: widget.controller,
            style: widget.style,
            onEditingComplete: () {
              _scaleDownTextField(widget.controller.text);
              widget.onEditingComplete(widget.controller.text);
              _isEditable = false;
            },
            onTapOutside: (_) {
              _scaleDownTextField(widget.controller.text);
              widget.onEditingComplete(widget.controller.text);
              _isEditable = false;
            },
            decoration: widget.decoration,
            autofocus: true,
            maxLines: widget.maxLines,
            textAlign: widget.textAlign,
            clipBehavior: Clip.none,
            keyboardType: widget.maxLines == 1
                ? TextInputType.text
                : TextInputType.multiline,
          )
        : GestureDetector(
            onTap: () {
              setState(() {
                _isEditable = true;
              });
            },
            child: Container(
              color: Colors.transparent,
              width: widget.width,
              height: widget.height,
              child: widget.maxLines == 1 ? Transform.scale(
                scaleY: _textScaleY > 1 ? _textScaleY : 1,
                alignment: _scaleAlignment(widget.maxLines),
                child:FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: _scaleAlignment(widget.maxLines),
                        child: Text(
                          widget.controller.text,
                          style: widget.style,
                        ),
                      )
              ) : Text(
                widget.controller.text,
                style: widget.style,
                textAlign: TextAlign.justify,
                textScaleFactor: _textLines > widget.maxLines
                    ? 1.0 / sqrt(_textLines / widget.maxLines)
                    : 1,
              ),
            ),
          );
  }
}
