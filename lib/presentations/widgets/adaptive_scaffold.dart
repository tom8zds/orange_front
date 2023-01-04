import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdaptiveScaffold extends StatefulWidget {
  final List<AdaptiveScaffoldDestination> destinations;
  final Widget child;
  final PreferredSizeWidget? appbar;

  const AdaptiveScaffold({
    Key? key,
    required this.child,
    required this.destinations,
    this.appbar,
  }) : super(key: key);

  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

enum NavType { bottom, rail, panel }

extension NavTypeX on NavType {
  double getWidth() {
    switch (this) {
      case NavType.bottom:
        return 0;
      case NavType.rail:
        return 72;
      case NavType.panel:
        return 304;
    }
  }
}

class AdaptiveScaffoldDestination {
  final Widget icon;
  final String title;
  final String route;

  AdaptiveScaffoldDestination({
    required this.route,
    required this.icon,
    required this.title,
  });

  Widget get label => Text(title);
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  int _selectedIndex = 0;
  NavType _navType = NavType.rail;

  // void applyAcrylic() async {
  //   await Window.setEffect(
  //     effect: WindowEffect.mica,
  //     dark: false,
  //   );
  // }

  void checkWidth() {
    double width = MediaQuery.of(context).size.width;
    if (width > 960) {
      if (_navType == NavType.bottom) {
        _navType = NavType.rail;
      }
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _navType = NavType.panel;
        });
      });
      return;
    }
    if (width > 640) {
      _navType = NavType.rail;
      return;
    }
    if (_navType == NavType.panel) {
      _navType = NavType.rail;
    }
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _navType = NavType.bottom;
      });
    });
  }

  Widget buildSideNavigator() {
    switch (_navType) {
      case NavType.bottom:
        return Container();
      case NavType.rail:
        return NavigationRail(
          selectedIndex: _selectedIndex,
          onDestinationSelected: onNavigation,
          labelType: NavigationRailLabelType.all,
          destinations: widget.destinations
              .map(
                (e) => NavigationRailDestination(
                  icon: e.icon,
                  label: e.label,
                ),
              )
              .toList(),
        );
      case NavType.panel:
        return Drawer(
          child: Column(
            children: [
              for (int index = 0; index < widget.destinations.length; index++)
                SizedBox(
                  width: 304,
                  child: ListTile(
                    leading: widget.destinations.elementAt(index).icon,
                    title: widget.destinations.elementAt(index).label,
                    selected: index == _selectedIndex,
                    onTap: () {
                      onNavigation(index);
                    },
                  ),
                ),
            ],
          ),
        );
    }
  }

  void checkPath() {
    int index = widget.destinations.indexWhere(
      (element) => GoRouter.of(context).location.startsWith(element.route),
    );
    if (index != -1) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void onNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.go(widget.destinations.elementAt(index).route);
  }

  @override
  Widget build(BuildContext context) {
    // applyAcrylic();
    checkWidth();
    checkPath();
    return Scaffold(
      appBar: widget.appbar,
      body: Row(
        children: <Widget>[
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: _navType.getWidth(),
            child: buildSideNavigator(),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).cardColor,
              child: widget.child,
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: _navType == NavType.bottom ? 80 : 0,
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: onNavigation,
          destinations: widget.destinations
              .map(
                (e) => NavigationDestination(
                  icon: e.icon,
                  label: e.title,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
