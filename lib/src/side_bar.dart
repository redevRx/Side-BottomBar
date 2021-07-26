import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:side_bottombar/src/provider/side_provider.dart';
import 'package:side_bottombar/src/side_item.dart';

///### SideBottomBar
/// make material botton navigation bar
///## Example
/// ``` dart
///SideBottonBar(
///   backgroundColor: Colors.white,
///   onTab: (int index) async {
///     print("home screen tab Index: $index");
///   },
///   sideItems: [
///     SideItem(
///       icon: Icons.home,
///       message: "Home",
///       color: Colors.blueAccent,
///     ),
///     SideItem(
///       icon: Icons.person,
///       message: "Person",
///       color: Colors.amberAccent,
///     ),
///    SideItem(
///       icon: Icons.translate_rounded,
///       message: "Translate",
///       color: Colors.blue,
///     ),
///     SideItem(
///       icon: Icons.settings,
///       message: "Setting",
///       color: Colors.grey,
///     )
///   ],
/// )
///
class SideBottomBar extends StatelessWidget {
  const SideBottomBar(
      {Key? key,
        this.backgroundColor = Colors.white,
        this.onTab,
        required this.sideItems})
      : super(key: key);

  ///background color tab menu
  final Color? backgroundColor;

  ///function tab will return index of tab
  final Function(int index)? onTab;

  ///list side menu items
  final List<SideItem> sideItems;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SideProvider>(
      create: (context) => SideProvider(),
      child: SideMenuBar(
        sideItems: sideItems,
        backgroundColor: backgroundColor,
        onTab: onTab,
      ),
    );
  }
}

class SideMenuBar extends StatelessWidget {
  const SideMenuBar(
      {Key? key, this.backgroundColor, this.onTab, required this.sideItems})
      : super(key: key);

  final Color? backgroundColor;
  final Function(int index)? onTab;
  final List<SideItem> sideItems;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: backgroundColor!.withOpacity(.12),
                blurRadius: 50,
                offset: Offset(27.0, 27.0),
                spreadRadius: .5)
          ]),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buildMenuItems(context)),
    );
  }

  List<Widget> _buildMenuItems(BuildContext context) {
    List<Widget> _barItems = [];
    for (int i = 0; i < sideItems.length; i++) {
      SideItem menuItem = sideItems[i];
      _barItems.add(Consumer<SideProvider>(
        builder: (context, value, child) {
          return SideItem(
            icon: menuItem.icon,
            color: menuItem.color,
            border: context.read<SideProvider>().currentIndex == i,
            message: menuItem.message,
            textColor: menuItem.textColor,
            size: menuItem.size,
            onTabIcon: () async {
              onTab!(i);
              Provider.of<SideProvider>(context, listen: false)
                  .onCurrentIndex(i);
              // context.watch<SideProvider>().onCurrentIndex(i);
            },
          );
        },
      ));
    }
    return _barItems;
  }
}
