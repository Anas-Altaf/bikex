import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Slide to action button - user swipes to complete action
class SlideToActionButton extends StatefulWidget {
  const SlideToActionButton({
    required this.label,
    required this.onSlideComplete,
    this.height = 50,
    this.disabled = false,
    super.key,
  });

  final String label;
  final VoidCallback onSlideComplete;
  final double height;
  final bool disabled;

  @override
  State<SlideToActionButton> createState() => _SlideToActionButtonState();
}

class _SlideToActionButtonState extends State<SlideToActionButton> {
  double _dragPosition = 0;
  bool _isCompleted = false;

  double get _maxDrag =>
      MediaQuery.of(context).size.width - 40 - widget.height - 20;

  double get _progress => (_dragPosition / _maxDrag).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    final thumbSize = widget.height - 6;

    return Container(
      height: widget.height,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: AppTheme.boxDecoration01,
      child: Stack(
        children: [
          // Label - fades as user slides
          Positioned.fill(
            child: Center(
              child: Opacity(
                opacity: 1 - _progress,
                child: Padding(
                  padding: EdgeInsets.only(left: thumbSize + 16),
                  child: Text(
                    widget.label,
                    style: const TextStyle(
                      color: AppTheme.textDescColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Draggable thumb
          Positioned(
            left: 3 + _dragPosition,
            top: 3,
            child: GestureDetector(
              onHorizontalDragUpdate: widget.disabled
                  ? null
                  : (details) {
                      if (_isCompleted) return;
                      setState(() {
                        _dragPosition = (_dragPosition + details.delta.dx)
                            .clamp(0, _maxDrag);
                      });
                    },
              onHorizontalDragEnd: widget.disabled
                  ? null
                  : (details) {
                      if (_isCompleted) return;
                      if (_progress >= 0.9) {
                        // Complete the action
                        setState(() {
                          _isCompleted = true;
                          _dragPosition = _maxDrag;
                        });
                        widget.onSlideComplete();
                      } else {
                        // Reset position
                        setState(() {
                          _dragPosition = 0;
                        });
                      }
                    },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: thumbSize,
                height: thumbSize,
                decoration: BoxDecoration(
                  gradient: widget.disabled ? null : AppTheme.primaryGradient2,
                  color: widget.disabled
                      ? AppTheme.backgroundSurfaceColor
                      : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _isCompleted ? Icons.check : Icons.chevron_right,
                  color: widget.disabled
                      ? AppTheme.textDescColor
                      : Colors.white,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Reset the slider state
  void reset() {
    setState(() {
      _dragPosition = 0;
      _isCompleted = false;
    });
  }
}
