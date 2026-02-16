import 'package:flutter/material.dart' ;

class AnimatedButton extends StatefulWidget {
  final String initialText, finalText;
  final ButtonStyle buttonStyle;
  final IconData iconData;
  final double iconSize;
  final Duration animationDuration;
  final Function onTap;

  const AnimatedButton({
    required this.initialText,
    required this.finalText,
    required this.iconData,
    required this.iconSize,
    required this.animationDuration,
    required this.buttonStyle,
    required this.onTap});

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleFinalTextAnimation;
  ButtonState _currentState = ButtonState.SHOW_ONLY_TEXT;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.animationDuration)
      ..addListener(_animationListener)
      ..addStatusListener(_animationStatusListener);
    _scaleFinalTextAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  void _animationListener() {
    final _controllerValue = _controller.value;
    setState(() {
      _currentState = _controllerValue < 0.2
          ? ButtonState.SHOW_ONLY_ICON
          : _controllerValue > 0.8 ? ButtonState.SHOW_TEXT_ICON : _currentState;
    });
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onTap();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Material(
    elevation: widget.buttonStyle.elevation,
    borderRadius: BorderRadius.all(Radius.circular(widget.buttonStyle.borderRadius)),
    child: InkWell(
      onTap: _controller.forward,
      child: AnimatedContainer(
        duration: Duration(milliseconds: (widget.animationDuration.inMilliseconds * 0.2).round()),
        height: widget.iconSize + 16,
        decoration: _buildBoxDecoration(),
        padding: _buildEdgeInsets(),
        child: _buildRow(),
      ),
    ),
  );

  BoxDecoration _buildBoxDecoration() {
    final currentStateIsIcon = _currentState == ButtonState.SHOW_ONLY_ICON || _currentState == ButtonState.SHOW_TEXT_ICON;
    return BoxDecoration(
      color: currentStateIsIcon ? widget.buttonStyle.secondaryColor : widget.buttonStyle.primaryColor,
      border: Border.all(
        color: currentStateIsIcon ? widget.buttonStyle.primaryColor : Colors.transparent,
      ),
      borderRadius: BorderRadius.all(Radius.circular(widget.buttonStyle.borderRadius)),
    );
  }

  EdgeInsets _buildEdgeInsets() {
    return EdgeInsets.symmetric(
      horizontal: _currentState == ButtonState.SHOW_ONLY_ICON ? 16.0 : 48.0,
      vertical: 8.0,
    );
  }

  Row _buildRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (_currentState != ButtonState.SHOW_ONLY_TEXT)
          Icon(
            widget.iconData,
            size: widget.iconSize,
            color: widget.buttonStyle.primaryColor,
          ),
        if (_currentState == ButtonState.SHOW_TEXT_ICON) SizedBox(width: 30.0),
        _getTextWidget(),
      ],
    );
  }

  Widget _getTextWidget() {
    if (_currentState == ButtonState.SHOW_ONLY_TEXT) {
      return Text(
        widget.initialText,
        style: widget.buttonStyle.initialTextStyle,
      );
    } else if (_currentState == ButtonState.SHOW_ONLY_ICON) {
      return Container();
    } else {
      return ScaleTransition(
        scale: _scaleFinalTextAnimation,
        child: Text(
          widget.finalText,
          style: widget.buttonStyle.finalTextStyle,
        ),
      );
    }
  }
}

class ButtonStyle {
  final TextStyle initialTextStyle, finalTextStyle;
  final Color primaryColor, secondaryColor;
  final double elevation, borderRadius;

  ButtonStyle({
    required this.primaryColor,
    required this.secondaryColor,
    required this.initialTextStyle,
    required this.finalTextStyle,
    required this.elevation,
    required this.borderRadius});
}

enum ButtonState { SHOW_ONLY_TEXT, SHOW_ONLY_ICON, SHOW_TEXT_ICON }