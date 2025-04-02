import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_habit/core/extension/theme_extension.dart';
import 'package:go_habit/feature/root/bloc/bloc/bottom_navigation_bloc.dart';
import 'package:go_habit/feature/root/view/components/bottom_navbar.dart';
import 'package:go_habit/feature/root/widget/bottom_navigation_scope.dart';
import 'package:go_router/go_router.dart';

class RootPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const RootPage({
    required this.navigationShell,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationScope(
      child: BlocConsumer<BottomNavigationBloc, BottomNavigationState>(
        listener: _bottomNavListener,
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: context.theme.commonColors.white,
            // extendBody: true,
            // extendBodyBehindAppBar: true,
            // bottomNavigationBar: BottomNavBar(currentIndex: state.currentPageIndex),
            body: Stack(children: [
              navigationShell,
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomNavBar(currentIndex: state.currentPageIndex),
              ),
            ]),
          );
        },
      ),
    );
  }

  void _bottomNavListener(_, BottomNavigationState state) {
    final index = state.currentPageIndex;
    debugPrint('${state.currentPageIndex}');

    if (index == navigationShell.currentIndex) {
      return;
    }

    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
