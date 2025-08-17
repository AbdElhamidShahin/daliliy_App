import 'package:Tourism_app/viewmodels/cubit/Bloc.dart';
import 'package:Tourism_app/viewmodels/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 3;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentIndex);
  }

  void changeTab(int index) {
    setState(() {
      currentIndex = index;
    });
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DalilyCubit, DalilyState>(
      builder: (context, state) {
        final cubit = DalilyCubit.get(context);
        final screenWidth = MediaQuery.of(context).size.width;

        return Scaffold(
          body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: cubit.bottomScreens,
          ),
          bottomNavigationBar: SizedBox(
            height: 80,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: screenWidth,
                    height: 80,
                    color: Colors.white,
                  ),
                ),
         

                Positioned.fill(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(cubit.activeIcons.length, (index) {
                      final isSelected = currentIndex == index;
                      final iconPath = isSelected
                          ? cubit.activeIcons[index]
                          : cubit.inactiveIcons[index];

                      return GestureDetector(
                        onTap: () => changeTab(index),
                        child: Container(
                          alignment: Alignment.center,
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black, Colors.black87],
                                stops: [0.0, 0.8],
                              ).createShader(bounds);
                            },
                            blendMode: BlendMode.srcIn,
                            child: SvgPicture.asset(
                              iconPath,
                              width: 32,
                              height: 32,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

