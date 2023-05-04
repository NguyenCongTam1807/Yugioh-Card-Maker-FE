import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/presentation/card_creating_screen/card_creator_view_model.dart';

import '../../application/dependency_injection.dart';

class ElasticTextField extends StatefulWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final Function(String) onEditingComplete;
  final TextStyle style;
  final int maxLines;
  final TextAlign textAlign;
  final Alignment? scaleAlignment;
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
      this.scaleAlignment,
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

  final _cardCreatorViewModel = getIt<CardCreatorViewModel>();

  double _textWidthInOneLine(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: double.infinity);

    return textPainter.width;
  }

  int _textLinesBoundByWidget(
      String text, TextStyle style, double widgetWidth) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: widgetWidth);

    return textPainter.computeLineMetrics().length;
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

  void _setCardDescMaxLine() {
    if (_textLines > widget.maxLines) {
      _cardCreatorViewModel.setCardDescMaxLine(_textLines);
    }
  }

  void _onEditingCompleteOrCancel() {
    _scaleDownTextField(widget.controller.text);
    widget.onEditingComplete(widget.controller.text);
    _setCardDescMaxLine();
    _isEditable = false;
  }

  @override
  Widget build(BuildContext context) {
    _textLines = _cardCreatorViewModel.cardDescMaxLine;

    return _isEditable
        ? TextField(
            controller: widget.controller,
            style: widget.style,
            onEditingComplete: _onEditingCompleteOrCancel,
            onTapOutside: (_) {
              _onEditingCompleteOrCancel();
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
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: widget.width,
              height: widget.height,
              alignment: widget.scaleAlignment,
              child: widget.maxLines == 1
                  ? Transform.scale(
                     scaleY: _textScaleY > 1 ? _textScaleY : 1,
                      alignment: widget.scaleAlignment,
                      child: FittedBox(
                        alignment: widget.scaleAlignment??Alignment.centerLeft,
                        child: Text(
                          widget.controller.text,
                          style: widget.style,
                        ),
                      ))
                  : AutoSizeText(
                      widget.controller.text,
                      style: widget.style,
                      textAlign: TextAlign.justify,
                      minFontSize: 0,
                      stepGranularity: 0.1,
                      maxLines: _textLines > widget.maxLines
                          ? _textLines
                          : widget.maxLines,
                    ),
            ),
          );
  }
}
