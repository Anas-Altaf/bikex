import 'package:bikex/core/constants.dart';
import 'package:bloc/bloc.dart';

/// State for product detail bottom sheet
class ProductDetailSheetState {
  const ProductDetailSheetState({
    this.sheetSize = ProductDetailConstants.sheetMinSize,
    this.selectedTab = ProductDetailTab.none,
  });

  final double sheetSize;
  final ProductDetailTab selectedTab;

  ProductDetailSheetState copyWith({
    double? sheetSize,
    ProductDetailTab? selectedTab,
  }) {
    return ProductDetailSheetState(
      sheetSize: sheetSize ?? this.sheetSize,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}

/// Cubit for managing product detail bottom sheet size and tab selection
class ProductDetailSheetCubit extends Cubit<ProductDetailSheetState> {
  ProductDetailSheetCubit() : super(const ProductDetailSheetState());

  /// Update the sheet size when dragged
  void updateSheetSize(double size) {
    if (state.sheetSize != size) {
      // Auto-select tab based on sheet position
      ProductDetailTab newTab = state.selectedTab;
      
      if (size == ProductDetailConstants.sheetMinSize) {
        newTab = ProductDetailTab.none;
      } else if (size > ProductDetailConstants.sheetMinSize && 
                 state.selectedTab == ProductDetailTab.none) {
        newTab = ProductDetailTab.description;
      }
      
      emit(state.copyWith(
        sheetSize: size,
        selectedTab: newTab,
      ));
    }
  }

  /// Collapse the sheet to its initial size
  void collapseSheet() {
    emit(state.copyWith(
      sheetSize: ProductDetailConstants.sheetMinSize,
      selectedTab: ProductDetailTab.none,
    ));
  }

  /// Set the selected tab and expand the sheet
  void selectTab(ProductDetailTab tab) {
    emit(state.copyWith(
      selectedTab: tab,
      sheetSize: ProductDetailConstants.sheetMaxSize,
    ));
  }

  /// Get current sheet size
  double get currentSheetSize => state.sheetSize;
  
  /// Get current selected tab
  ProductDetailTab get currentTab => state.selectedTab;
}
