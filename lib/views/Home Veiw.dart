import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cubit/Bloc.dart';
import '../models/cubit/states.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DalilyCubit(),
      child: BlocConsumer<DalilyCubit, DalilyState>(
        listener: (BuildContext context, state) {},
        builder: (context, state) {
          final cubit = DalilyCubit.get(context);
          final theme = Theme.of(context);

          return Scaffold(
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: _buildElegantBottomNavBar(cubit, theme),
          );
        },
      ),
    );
  }

  Widget _buildElegantBottomNavBar(DalilyCubit cubit, ThemeData theme) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            cubit: cubit,
            index: 2,
            icon: Icons.person_outline,
            activeIcon: Icons.person_rounded,
            label: 'حسابي',
            theme: theme,
          ),
          _buildNavItem(
            cubit: cubit,
            index: 1,
            icon: Icons.favorite_outline,
            activeIcon: Icons.favorite_rounded,
            label: 'المفضلة',
            theme: theme,
          ),        _buildNavItem(
            cubit: cubit,
            index: 0,
            icon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: 'الرئيسية',
            theme: theme,
          ),

        ],
      ),
    );
  }

  Widget _buildNavItem({
    required DalilyCubit cubit,
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required ThemeData theme,
  }) {
    final isActive = cubit.currentIndex == index;
    final color = isActive ? theme.primaryColor : theme.unselectedWidgetColor;

    return GestureDetector(
      onTap: () => cubit.changeBottomNavBar(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: child,
            ),
            child: Icon(
              isActive ? activeIcon : icon,
              key: ValueKey(isActive),
              size: 28,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 3,
              width: 24,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }
}