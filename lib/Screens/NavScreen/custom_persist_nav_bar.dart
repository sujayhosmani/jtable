import "package:flutter/material.dart";
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";


class CustomWidgetExample extends StatefulWidget {
  const CustomWidgetExample({super.key});

  @override
  _CustomWidgetExampleState createState() => _CustomWidgetExampleState();
}

class _CustomWidgetExampleState extends State<CustomWidgetExample> {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() => [
    Text("1"),
    Text("2"),
    Text("3"),
    Text("4"),
    Text("5"),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: "Home",
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.search),
      title: "Search",
      activeColorPrimary: Colors.teal,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.add),
      title: "Add",
      activeColorPrimary: Colors.deepOrange,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.settings),
      title: "Settings",
      activeColorPrimary: Colors.indigo,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.settings),
      title: "Settings",
      activeColorPrimary: Colors.indigo,
      inactiveColorPrimary: Colors.grey,
    ),
  ];

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Navigation Bar Demo")),
    drawer: Drawer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text("This is the Drawer"),
          ],
        ),
      ),
    ),
    body: PersistentTabView.custom(
      context,
      controller: _controller,
      screens: _buildScreens(),
      itemCount: 5,
      handleAndroidBackButtonPress: false,
      hideNavigationBar: _hideNavBar,
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
      ),
      customWidget: CustomNavBarWidget(
        _navBarsItems(),
        onItemSelected: (final index) {
          setState(() {
            _controller.index = index; // THIS IS CRITICAL!! Don't miss it!
          });
        },
        selectedIndex: _controller.index,
      ),
    ),
  );
}


class CustomNavBarWidget extends StatelessWidget {
  const CustomNavBarWidget(
      this.items, {
        final Key? key,
        required this.selectedIndex,
        required this.onItemSelected,
      }) : super(key: key);
  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;

  Widget _buildItem(
      final PersistentBottomNavBarItem item, final bool isSelected) =>
      Container(
        alignment: Alignment.center,
        height: kBottomNavigationBarHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: IconTheme(
                data: IconThemeData(
                    size: 26,
                    color: isSelected
                        ? (item.activeColorSecondary ?? item.activeColorPrimary)
                        : item.inactiveColorPrimary ?? item.activeColorPrimary),
                child: isSelected ? item.icon : item.inactiveIcon ?? item.icon,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Material(
                type: MaterialType.transparency,
                child: FittedBox(
                    child: Text("eee",
                      style: TextStyle(
                          color: isSelected
                              ? (item.activeColorSecondary ??
                              item.activeColorPrimary)
                              : item.inactiveColorPrimary,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    )),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(final BuildContext context) => Container(
    color: Colors.white,
    child: SizedBox(
      width: double.infinity,
      height: kBottomNavigationBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((final item) {
          final int index = items.indexOf(item);
          return Flexible(
            child: GestureDetector(
              onTap: () {
                onItemSelected(index);
              },
              child: _buildItem(item, selectedIndex == index),
            ),
          );
        }).toList(),
      ),
    ),
  );
}