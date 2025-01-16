import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rahgosha/common/theme.dart';

class ConnectionWidget extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ConnectionWidget({
    super.key,
    required this.onTap,
    required this.isLoading,
    required this.status,
  });

  final bool isLoading;
  final GestureTapCallback onTap;
  final String status;
  
  bool get isConnected => status == "CONNECTED";

  @override
  State<ConnectionWidget> createState() => _ConnectionWidgetState();
}

class _ConnectionWidgetState extends State<ConnectionWidget> {

  Color get currentColor {
  if (widget.isLoading) {
    return themeColors.secondaryColor; 
  } else if (widget.isConnected) {
    return themeColors.primaryColor; 
  } else {
    return themeColors.redColor;
  }
}

  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
              color: currentColor.withAlpha(25),
              blurRadius: 200,
              spreadRadius: 100,
              ),
            ],
          ),
          child: Center(
            child: widget.isLoading
          ? LoadingAnimationWidget.threeArchedCircle(
              color: currentColor,
              size: 100,
            )
          : IconButton(
              onPressed: widget.onTap,
              icon: widget.status == "DISCONNECTED" ? Icon(
          Icons.play_circle_outline_rounded,
          size: 110,
          color: currentColor,
              ) : Icon(
          Icons.stop_circle_outlined,
          size: 110,
          color: currentColor,
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        Text(
          context.tr(
            widget.isLoading 
              ? "general.state.connecting" 
              : "general.state.${widget.status.toLowerCase()}"
          ),
          style: TextStyle(
            fontSize: 16, 
            color: currentColor
          ),
        ),
      ],
    );
  }
}
