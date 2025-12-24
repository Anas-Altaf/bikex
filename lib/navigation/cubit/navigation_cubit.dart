import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_state.dart';

/// Cubit for managing bottom navigation tab state
class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  /// Change the current tab index
  void changeTab(int index) {
    if (index != state.currentIndex && index >= 0 && index < 5) {
      emit(state.copyWith(currentIndex: index));
    }
  }
}
