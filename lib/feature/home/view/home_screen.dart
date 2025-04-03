import 'package:flutter/material.dart';
import 'package:go_habit/feature/home/widget/habit_home_list.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final Future<LottieComposition> _composition;
  late final AnimationController _textAnimationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _firstBubbleAnimation;
  late final Animation<double> _secondBubbleAnimation;

  @override
  void initState() {
    super.initState();
    _composition = AssetLottie('animation/tiger_orange.json').load();

    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
    ));

    _firstBubbleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textAnimationController,
      curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
    ));

    _secondBubbleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textAnimationController,
      curve: const Interval(0.2, 0.5, curve: Curves.easeInOut),
    ));

    Future.delayed(const Duration(milliseconds: 500), () {
      _textAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            title: const Text(
              'Go Habit',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.25,
                        bottom: -3,
                        child: FadeTransition(
                          opacity: _firstBubbleAnimation,
                          child: ScaleTransition(
                            scale: _firstBubbleAnimation,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.lightGreen.shade100,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(26),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.2,
                        bottom: 8,
                        child: FadeTransition(
                          opacity: _secondBubbleAnimation,
                          child: ScaleTransition(
                            scale: _secondBubbleAnimation,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.lightGreen.shade200,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(26),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.lightGreen.shade100,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(26),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IntrinsicWidth(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.pets, color: Colors.green.shade700),
                              const SizedBox(width: 8),
                              Flexible(
                                child: DefaultTextStyle(
                                  style: TextStyle(
                                    color: Colors.green.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      TypewriterAnimatedText(
                                        'Привет! Давай выполним привычки!',
                                        speed:
                                            const Duration(milliseconds: 100),
                                        cursor: '',
                                      ),
                                    ],
                                    isRepeatingAnimation: false,
                                    displayFullTextOnTap: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: SizedBox(
                    height: 300,
                    child: Center(
                      child: Hero(
                        tag: 'tiger_animation',
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: FutureBuilder<LottieComposition>(
                              future: _composition,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Lottie(
                                    composition: snapshot.data!,
                                    fit: BoxFit.contain,
                                    repeat: true,
                                    reverse: true,
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(top: 16, bottom: 120),
            sliver: HabitHomeList(),
          ),
        ],
      ),
    );
  }
}
