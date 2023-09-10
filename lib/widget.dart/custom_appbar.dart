import 'package:fl_pbi/library/app_theme.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.backgroundColor,
  });
  final String title;
  final Widget? actions;
  final Widget? leading;
  final Color? backgroundColor;
  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  double topBarOpacity = 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            widget.backgroundColor ?? AppTheme.white.withOpacity(topBarOpacity),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.grey.withOpacity(0.4 * topBarOpacity),
            offset: const Offset(1.1, 1.1),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 5,
              top: 16 - 8.0 * topBarOpacity,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                widget.leading ?? const SizedBox.shrink(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w700,
                        fontSize: 15 + 6 - 6 * topBarOpacity,
                        color: AppTheme.dismissibleBackground,
                      ),
                    ),
                  ),
                ),
                widget.actions ?? const SizedBox.shrink()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
