import 'package:flutter/material.dart';
import 'package:go_habit/core/extension/theme_extension.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.2, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.4, curve: Curves.easeOut),
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.7, 0.9, curve: Curves.easeIn),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.scale(
                            scale: _scaleAnimation.value,
                            child: _buildGithubStyleChart(context),
                          ),
                          const SizedBox(height: 50),
                          FadeTransition(
                            opacity: _opacityAnimation,
                            child: const Text(
                              'Добро пожаловать в Go Habit',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Здесь будет навигация к основному экрану привычек
                      Navigator.of(context).pushReplacementNamed('/main');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Начать',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGithubStyleChart(BuildContext context) {
    // Настраиваем цвета
    const neutralGrey = Color.fromARGB(255, 33, 43, 39);
    final greenColor = context.theme.commonColors.green100;
    final animatedGreenColor = ColorTween(
      begin: neutralGrey,
      end: greenColor,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 0.7, curve: Curves.elasticOut),
      ),
    );

    // Определяем размеры и расстояния
    const rows = 7;
    const columns = 12;
    const cubeSize = 16.0;
    const cubeSpacing = 4.0;

    // Рассчитываем общий размер с учетом отступов
    const padding = 16.0;
    const width = (columns * (cubeSize + cubeSpacing)) + padding * 2;
    const height = (rows * (cubeSize + cubeSpacing)) + padding * 2;

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: cubeSpacing,
          mainAxisSpacing: cubeSpacing,
        ),
        itemCount: rows * columns,
        itemBuilder: (context, index) {
          // Последний кубик с анимацией
          final isLastCube = index == rows * columns - 1;

          return Container(
            width: cubeSize,
            height: cubeSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: isLastCube
                  ? animatedGreenColor.value
                  : const Color.fromARGB(255, 33, 43, 39),
              border: Border.all(
                color: Colors.black12,
                width: 0.5,
              ),
            ),
          );
        },
      ),
    );
  }
}
