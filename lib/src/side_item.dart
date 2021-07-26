import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///### SideItem
///menu Item for SideBar
///## Example
/// ``` dart
///   SideItem(
///   icon: Icons.home,
///   message: "Home",
///   color: Colors.blueAccent,
/// ),
///
class SideItem extends StatefulWidget {
  const SideItem({
    Key? key,
    this.border = false,
    required this.icon,
    this.size = 26,
    this.message = "",
    this.color = Colors.white,
    this.textColor = Colors.white,
    this.onTabIcon,
  }) : super(key: key);

  @override
  _SideItemState createState() => _SideItemState();

  ///Icon menu bar
  final IconData icon;

  ///size icon
  final double size;

  /// color icon
  final Color color;

  ///make border
  final bool border;

  ///message
  final String message;

  ///text color
  final Color textColor;

  ///function onTab
  final Function? onTabIcon;
}

class _SideItemState extends State<SideItem>
    with SingleTickerProviderStateMixin {
  //
  late final AnimationController _controller =
  AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

  //offset
  late final Animation<Offset> _offsetAnimate =
  Tween<Offset>(begin: Offset.zero, end: Offset(0.0, -1.5))
      .animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceIn,
  ));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _controller..forward();
        widget.onTabIcon!();
        await Future.delayed(Duration(milliseconds: 1000), () {
          _controller..reverse();
        });
      },
      child: SlideTransition(
        position: _offsetAnimate,
        child: widget.border && widget.message.isNotEmpty
            ? Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          decoration: BoxDecoration(
              color: widget.color.withOpacity(.23),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(.12),
                  blurRadius: 50.0,
                  offset: Offset(50.0, 50.0),
                  spreadRadius: 5.0,
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                widget.icon,
                size: widget.size,
                color: widget.color,
              ),
              //
              Text(
                widget.message,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: widget.textColor),
              )
            ],
          ),
        )
            : Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
              color: widget.color.withOpacity(.23),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(.12),
                  blurRadius: 50.0,
                  offset: Offset(50.0, 50.0),
                  spreadRadius: 5.0,
                )
              ]),
          child: Icon(
            widget.icon,
            size: widget.size,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}
