import 'package:bloc/bloc.dart';

/// State for product detail bottom sheet
class ProductDetailSheetState {
  const ProductDetailSheetState({this.sheetSize = 0.13});

  final double sheetSize;

  ProductDetailSheetState copyWith({double? sheetSize}) {
    return ProductDetailSheetState(
      sheetSize: sheetSize ?? this.sheetSize,
    );
  }
}

/// Cubit for managing product detail bottom sheet size
class ProductDetailSheetCubit extends Cubit<ProductDetailSheetState> {
  ProductDetailSheetCubit() : super(const ProductDetailSheetState());

  /// Update the sheet size when dragged
  void updateSheetSize(double size) {
    if (state.sheetSize != size) {
      emit(state.copyWith(sheetSize: size));
    }
  }

  /// Collapse the sheet to its initial size
  void collapseSheet() {
    emit(state.copyWith(sheetSize: 0.13));
  }

  /// get current sheet size
  double get currentSheetSize => state.sheetSize;
}
