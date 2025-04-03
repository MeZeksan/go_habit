import 'package:flutter/material.dart';
import 'package:go_habit/core/extension/theme_extension.dart';
import 'package:go_habit/core/resources/assets.gen.dart';
import 'package:go_habit/feature/root/widget/bottom_navigation_scope.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({required this.currentIndex, super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    return Container(
      margin: const EdgeInsets.all(40),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      height: 40 + bottomPadding,
      child: Row(
        spacing: 20,
        children: [
          Expanded(
            child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              color: context.themeOf.cardColor,
              child: SizedBox(
                height: 64,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavBarItem(
                      onTap: (index) => BottomNavigationScope.change(context, index),
                      index: 0,
                      currentIndex: currentIndex,
                      asset: Assets.navbarIcons.home,
                    ),
                    _NavBarItem(
                      onTap: (index) => BottomNavigationScope.change(context, index),
                      index: 1,
                      currentIndex: currentIndex,
                      asset: Assets.navbarIcons.edit,
                    ),
                    _NavBarItem(
                      onTap: (index) => BottomNavigationScope.change(context, index),
                      index: 2,
                      currentIndex: currentIndex,
                      asset: Assets.navbarIcons.bell,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Material(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            color: context.themeOf.cardColor,
            child: SizedBox(
              height: 64,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _NavBarItem(
                  onTap: (index) => BottomNavigationScope.change(context, index),
                  index: 3,
                  currentIndex: currentIndex,
                  asset: Assets.navbarIcons.user,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.index,
    required this.currentIndex,
    required this.onTap,
    required this.asset,
  });

  final int index;
  final int currentIndex;
  final SvgGenImage asset;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;
    final isSelected = index == currentIndex;
    return InkWell(
      onTap: () => onTap(index),
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: Ink(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? context.themeOf.dividerColor : context.themeOf.cardColor,
        ),
        padding: const EdgeInsets.all(12),
        child: index == 2
            ? Badge.count(
                count: 2,
                child: asset.svg(
                  colorFilter: ColorFilter.mode(
                    isSelected ? context.themeOf.primaryColor : colors.darkGrey30,
                    BlendMode.srcIn,
                  ),
                ))
            : asset.svg(
                colorFilter: ColorFilter.mode(
                  isSelected ? context.themeOf.primaryColor : colors.darkGrey30,
                  BlendMode.srcIn,
                ),
              ),
      ),
    );
  }
}
