import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/models/theme_mode_state.dart';
import 'package:life_counter/shared/constants/constants.dart';

class DayNightAnimator extends ConsumerStatefulWidget {
  final NotifierProvider<dynamic, ThemeModeState> themeModeProvider;

  const DayNightAnimator({
    required this.themeModeProvider,
    super.key,
  });

  @override
  ConsumerState<DayNightAnimator> createState() => _DayNightAnimatorState();
}

class _DayNightAnimatorState extends ConsumerState<DayNightAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;

  // Track whether listener has fired at least once (or just rely on previous!=next in listen)
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: dayNightAnimationDuration,
    );

    _opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.5), weight: 20),
      TweenSequenceItem(tween: ConstantTween(0.5), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 0.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scale = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to theme changes
    ref.listen(widget.themeModeProvider, (previous, next) {
      // Logic: Only animate if it's NOT a reset (isInitialMode is false)
      // AND there's an actual change or it's the first time running
      // However, usually we just want to suppress animation on reset.
      if (_initialized && !next.isInitialMode) {
        _playAnimation();
      }
      _initialized = true;
    });

    // Also watch to get current icon, though animation trigger is in listener
    final themeState = ref.watch(widget.themeModeProvider);
    final isLight = themeState.themeMode == ThemeMode.light;

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final opacityVal = _opacity.value;
          // Calculate dimmer opacity: stronger for Day to show the sun glow
          final dimmerOpacity = isLight ? 0.3 * opacityVal : 0.5 * opacityVal;

          return Stack(
            fit: StackFit.expand,
            children: [
              // 1. Dimmer Overlay (Makes lights pop on any background)
              Container(color: Colors.black.withValues(alpha: dimmerOpacity)),

              // 2. The Icon/Orb
              Opacity(
                opacity: opacityVal,
                child: Transform.scale(
                  scale: _scale.value,
                  child: Center(
                    child: isLight ? _buildSun(context) : _buildMoon(context),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSun(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: [
            Color(0xFFFFF9C4), // Light yellow core
            Color(0xFFFFB74D), // Orange middle
            Color(0x00FF9800), // Transparent edge
          ],
          stops: [0.1, 0.4, 0.8],
          center: Alignment.center,
        ),
        boxShadow: [
          // Vast, soft outer glow
          BoxShadow(
            color: Colors.orangeAccent.withValues(alpha: 0.3),
            blurRadius: 100,
            spreadRadius: 50,
          ),
          // Inner glow
          BoxShadow(
            color: Colors.yellowAccent.withValues(alpha: 0.3),
            blurRadius: 50,
            spreadRadius: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildMoon(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: [
            Color(0x8890A4AE), // Mid-tone with transparency
            Color(0xaa263238), // Shadow
            // Color(0x00000000), // Transparent
          ],
          stops: [0.2, 0.5],
          center: Alignment.center,
        ),
        boxShadow: [
          // Vast, soft blueish glow
          BoxShadow(
            color: Colors.blueAccent.withValues(alpha: 0.3),
            blurRadius: 120,
            spreadRadius: 40,
          ),
          // Subtle halo
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.1),
            blurRadius: 40,
            spreadRadius: 5,
          ),
        ],
      ),
    );
  }

  void _playAnimation() {
    _controller.forward(from: 0.0);
  }
}
