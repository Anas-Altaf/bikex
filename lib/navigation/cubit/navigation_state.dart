part of 'navigation_cubit.dart';

/// Navigation tab indices
enum NavTab {
  bikes(0),
  map(1),
  cart(2),
  profile(3),
  orders(4);

  const NavTab(this.tabIndex);
  final int tabIndex;
}

/// State for navigation cubit
class NavigationState extends Equatable {
  const NavigationState({
    this.currentIndex = 0,
  });

  final int currentIndex;

  /// Get current tab as enum
  NavTab get currentTab => NavTab.values[currentIndex];

  NavigationState copyWith({
    int? currentIndex,
  }) {
    return NavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object> get props => [currentIndex];
}
