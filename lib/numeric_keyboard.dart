library numeric_keyboard;

import 'package:flutter/material.dart';

typedef KeyboardTapCallback = void Function(String text);

class NumericKeyboard extends StatefulWidget {
  /// Color of the text [default = Colors.black]
  final Color textColor;
  final Color? buttonBackgroundColor;

  final bool showExtraButtons;

  /// Display a custom right icon
  final Icon? rightIcon;

  /// Action to trigger when right button is pressed
  final Function()? rightButtonFn;

  /// Display a custom left icon
  final Icon? leftIcon;

  /// Action to trigger when left button is pressed
  final Function()? leftButtonFn;

  /// Callback when an item is pressed
  final KeyboardTapCallback onKeyboardTap;

  /// Main axis alignment [default = MainAxisAlignment.spaceEvenly]
  final MainAxisAlignment mainAxisAlignment;

  NumericKeyboard({
    Key? key,
    required this.onKeyboardTap,
    this.textColor = Colors.black,
    this.rightButtonFn,
    this.rightIcon,
    this.leftButtonFn,
    this.leftIcon,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.buttonBackgroundColor,
    this.showExtraButtons = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NumericKeyboardState();
  }
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 32, right: 32, top: 20),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('1'),
              _calcButton('2'),
              _calcButton('3'),
              if (widget.showExtraButtons)
                _calcButton('10',
                    backgroundColor: widget.buttonBackgroundColor),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('4'),
              _calcButton('5'),
              _calcButton('6'),
              if (widget.showExtraButtons)
                _calcButton('20',
                    backgroundColor: widget.buttonBackgroundColor),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('7'),
              _calcButton('8'),
              _calcButton('9'),
              if (widget.showExtraButtons)
                _calcButton('50',
                    backgroundColor: widget.buttonBackgroundColor),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              InkWell(
                  borderRadius: BorderRadius.circular(45),
                  onTap: widget.leftButtonFn,
                  child: Container(
                      decoration: new BoxDecoration(
                          color:
                              widget.buttonBackgroundColor ?? Color(0xFFEBEDF0),
                          borderRadius: new BorderRadius.all(
                              const Radius.circular(10.0))),
                      alignment: Alignment.center,
                      width: 100,
                      height: 100,
                      child: widget.leftIcon)),
              _calcButton('0'),
              if (widget.showExtraButtons) _calcButton('.'),
              InkWell(
                  borderRadius: BorderRadius.circular(45),
                  onTap: widget.rightButtonFn,
                  child: Container(
                      decoration: new BoxDecoration(
                          color:
                              widget.buttonBackgroundColor ?? Color(0xFFEBEDF0),
                          borderRadius: new BorderRadius.all(
                              const Radius.circular(10.0))),
                      alignment: Alignment.center,
                      width: 100,
                      height: 100,
                      child: widget.rightIcon))
            ],
          ),
        ],
      ),
    );
  }

  Widget _calcButton(String value, {Color? backgroundColor}) {
    return InkWell(
        borderRadius: BorderRadius.circular(45),
        onTap: () {
          widget.onKeyboardTap(value);
        },
        child: Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: backgroundColor ?? Color(0xFFEBEDF0),
              borderRadius: new BorderRadius.all(const Radius.circular(10.0))),
          // width: MediaQuery.of(context).size.width * 0.11,
          // height: MediaQuery.of(context).size.height * 0.07,
          width: 100,
          height: 100,
          child: Text(
            value,
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color:
                    backgroundColor == null ? widget.textColor : Colors.white),
          ),
        ));
  }
}
