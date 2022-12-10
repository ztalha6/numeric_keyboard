import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numeric Keyboard Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Numeric Keyboard Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ValueNotifier<String> _myString = ValueNotifier<String>('');
  ValueNotifier<String> _myString1 = ValueNotifier<String>('');
  ValueNotifier<String> _myString2 = ValueNotifier<String>('');

  FocusNode _focus = FocusNode();
  FocusNode _focus1 = FocusNode();
  FocusNode _focus2 = FocusNode();

  TextEditingController _controller = TextEditingController();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  @override
  void initState() {
    _focus.addListener(_onFocusChange);
    _focus1.addListener(_onFocusChange);
    _focus2.addListener(_onFocusChange);
    _myString.addListener(() => _controller.text = _myString.value);

    super.initState();
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      _myString.addListener(() => _controller.text = _myString.value);
    }
    if (_focus1.hasFocus) {
      _myString1.addListener(() => _controller1.text = _myString1.value);
    }
    if (_focus2.hasFocus) {
      _myString2.addListener(() => _controller2.text = _myString2.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(_myString.value),
          new TextField(
            readOnly: true,
            focusNode: _focus,
            controller: _controller,
          ),
          new TextField(
            focusNode: _focus1,
            readOnly: true,
            controller: _controller1,
          ),
          new TextField(
            focusNode: _focus2,
            readOnly: true,
            controller: _controller2,
          ),
          Padding(
            // padding: const EdgeInsets.symmetric(horizontal: 420.0),
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: NumericKeyboard(
              // showExtraButtons: true,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              buttonBackgroundColor: Colors.blue,
              onKeyboardTap: _onKeyboardTap,
              // textColor: Colors.b,
              rightButtonFn: () {
                setState(() {
                  if (_focus.hasFocus) {
                    _myString.value = _myString.value
                        .substring(0, _myString.value.length - 1);
                  }
                  if (_focus1.hasFocus) {
                    _myString1.value = _myString1.value
                        .substring(0, _myString1.value.length - 1);
                  }
                  if (_focus2.hasFocus) {
                    _myString2.value = _myString2.value
                        .substring(0, _myString2.value.length - 1);
                  }
                });
              },
              rightIcon: Icon(
                Icons.backspace,
                color: Colors.white,
              ),
              leftButtonFn: () {
                print('left button clicked');
              },
              leftIcon: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onKeyboardTap(String value) {
    setState(() {
      if (_focus.hasFocus) {
        _myString.value = _myString.value + value;
      }
      if (_focus1.hasFocus) {
        _myString1.value = _myString1.value + value;
      }
      if (_focus2.hasFocus) {
        _myString2.value = _myString2.value + value;
      }
    });
  }
}
