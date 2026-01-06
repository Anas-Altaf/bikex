import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Slide to action button - user swipes to complete action
/// Matches the GradientCheckoutButton style (174x44) with slide functionality
class SlideToActionButton extends StatefulWidget {
  const SlideToActionButton({
    required this.label,
    required this.onSlideComplete,
    this.width = 174,
    this.height = 44,
    this.disabled = false,
    super.key,
  });

  final String label;
  final VoidCallback onSlideComplete;
  final double width;
  final double height;
  final bool disabled;

  @override
  State<SlideToActionButton> createState() => SlideToActionButtonState();
}

class SlideToActionButtonState extends State<SlideToActionButton>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0;
  bool _isCompleted = false;
  late AnimationController _animationController;
  late Animation<double> _resetAnimation;

  double get _thumbSize => widget.height;
  double get _maxDrag => widget.width - _thumbSize;
  double get _progress =>
      _maxDrag > 0 ? (_dragPosition / _maxDrag).clamp(0.0, 1.0) : 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _resetAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.addListener(() {
      setState(() {
        _dragPosition = _resetAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_isCompleted || widget.disabled) return;
    setState(() {
      _dragPosition = (_dragPosition + details.delta.dx).clamp(0.0, _maxDrag);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_isCompleted || widget.disabled) return;

    if (_progress >= 0.85) {
      // Complete the action - animate to end
      _animateToPosition(
        _maxDrag,
        onComplete: () {
          setState(() {
            _isCompleted = true;
          });
          widget.onSlideComplete();
        },
      );
    } else {
      // Reset - animate back to start
      _animateToPosition(0);
    }
  }

  void _animateToPosition(double target, {VoidCallback? onComplete}) {
    _resetAnimation =
        Tween<double>(
          begin: _dragPosition,
          end: target,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOut,
          ),
        );

    _animationController.reset();
    _animationController.forward().then((_) {
      onComplete?.call();
    });
  }

  /// Reset the slider to initial state
  void reset() {
    setState(() {
      _dragPosition = 0;
      _isCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: AppTheme.boxDecoration01,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Label - positioned in center of available space
          Positioned.fill(
            child: Row(
              children: [
                SizedBox(width: _thumbSize), // Space for thumb
                Expanded(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 100),
                    opacity: _isCompleted ? 0 : (1 - _progress * 0.5),
                    child: Center(
                      child: Text(
                        _isCompleted ? 'Done!' : widget.label,
                        style: const TextStyle(
                          color: AppTheme.textDescColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Draggable thumb - always visible
          Positioned(
            left: _dragPosition,
            top: 0,
            child: GestureDetector(
              onHorizontalDragUpdate: _onDragUpdate,
              onHorizontalDragEnd: _onDragEnd,
              child: Container(
                width: _thumbSize,
                height: _thumbSize,
                decoration: BoxDecoration(
                  gradient: widget.disabled ? null : AppTheme.primaryGradient2,
                  color: widget.disabled
                      ? AppTheme.backgroundSurfaceColor
                      : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    _isCompleted ? Icons.check : Icons.chevron_right,
                    key: ValueKey(_isCompleted),
                    color: widget.disabled
                        ? AppTheme.textDescColor
                        : Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
