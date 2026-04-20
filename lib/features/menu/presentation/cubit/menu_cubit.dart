import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_system/core/enums/request_state.dart';
import 'package:food_ordering_system/features/menu/domain/entities/category_item.dart';
import 'package:food_ordering_system/features/menu/domain/usecases/get_menu_items.dart';
import 'package:food_ordering_system/features/menu/domain/usecases/search_menu_items.dart';
import 'package:food_ordering_system/features/menu/presentation/cubit/menu_state.dart';

/// The State Management controller for the Menu feature.
///
/// This Cubit acts as the brain of the Menu screen. It listens to UI events
/// (like opening the screen, scrolling to the bottom, or typing in a search bar),
/// executes the pure Domain layer Use Cases, and emits new [MenuState] objects
/// to trigger UI rebuilds.
class MenuCubit extends Cubit<MenuState> {
  final GetMenuItems getMenuItemsUseCase;
  final SearchMenuItems searchMenuItemsUseCase;

  MenuCubit({
    required this.getMenuItemsUseCase,
    required this.searchMenuItemsUseCase,
  }) : super(const MenuState());

  /// Fetches a paginated list of menu items.
  ///
  /// This method handles "Infinite Scrolling". When called for page 1, it loads
  /// the initial data. When called for subsequent pages, it appends the new
  /// items to the existing list without wiping the screen.
  ///
  /// Takes a [page] integer representing the current pagination index.
  Future<void> getMenu({required int page}) async {
    // 1. Guard clause: Prevent unnecessary API spam if we've already
    // fetched every single product from the backend database.
    if (state.hasReachedMax) return;

    // 2. Emit loading state using copyWith.
    // This changes the status to trigger a loading spinner at the bottom
    // of the list, but PRESERVES the existing products on the screen.
    emit(state.copyWith(status: RequestState.loading));

    // 3. Execute the Use Case
    final result = await getMenuItemsUseCase(
      page: page,
      categorySlug: state.selectedCategory.slug == 'all'
          ? null
          : state.selectedCategory.slug,
    );
    // 4. Handle the result
    result.fold(
      (failure) {
        // Emit error state with the specific backend or local cache message
        emit(
          state.copyWith(
            status: RequestState.error,
            errorMessage: failure.message,
          ),
        );
      },
      (newProducts) {
        if (newProducts.isEmpty) {
          // If the API returns an empty list, we've hit the end of the database.
          emit(
            state.copyWith(status: RequestState.success, hasReachedMax: true),
          );
        } else {
          // IMPORTANT: We must use List.of() to create a totally new object in memory.
          // If we just called state.products.addAll(), Equatable would think the
          // state hasn't changed and the UI would refuse to rebuild!
          final updatedList = List.of(state.products)..addAll(newProducts);

          emit(
            state.copyWith(
              status: RequestState.success,
              products: updatedList,
              hasReachedMax:
                  false, // Ensure we can still try to fetch the next page later
            ),
          );
        }
      },
    );
  }

  /// Searches the menu for a specific text query.
  ///
  /// Unlike [getMenu], this method intentionally wipes the current products list
  /// to ensure the UI only displays the exact items matching the [query].
  Future<void> searchMenu(String query) async {
    // Clear the current list and show a full-screen loading indicator
    emit(
      state.copyWith(
        status: RequestState.loading,
        products: const [],
        hasReachedMax: false,
        searchQuery: query,
      ),
    );

    // Execute the Search Use Case
    final result = await searchMenuItemsUseCase(
      query: query,
      categorySlug: state.selectedCategory.slug,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: RequestState.error,
            errorMessage: failure.message,
          ),
        );
      },
      (searchResults) {
        // Display the filtered results. We set hasReachedMax to true
        // assuming search results are returned as a single unpaginated batch.
        emit(
          state.copyWith(
            status: RequestState.success,
            products: searchResults,
            hasReachedMax: true,
          ),
        );
      },
    );
  }


  Future<void> clearSearch() async {
    emit(state.copyWith(searchQuery: '')); // Wipe the query from memory
    await selectCategory(state.selectedCategory); // Reload the standard category grid
  }

  Future<void> selectCategory(CategoryItem category) async {
    emit(state.copyWith(
      status: RequestState.loading,
      products: const [],
      selectedCategory: category,
    ));

    // Check if we are currently searching!
    if (state.searchQuery.isNotEmpty) {
      // If searching, run the search use case with the new category
      final result = await searchMenuItemsUseCase(
        query: state.searchQuery,
        categorySlug: category.slug,
      );

      result.fold(
            (failure) => emit(state.copyWith(status: RequestState.error, errorMessage: failure.message)),
            (filteredResult) => emit(state.copyWith(status: RequestState.success, products: filteredResult, hasReachedMax: true)),
      );
    } else {
      // If NOT searching, run the standard pagination fetch
      final result = await getMenuItemsUseCase(
          page: 1,
          categorySlug: category.slug == 'all' ? null : category.slug
      );

      result.fold(

            (failure) => emit(state.copyWith(status: RequestState.error, errorMessage: failure.message)),
            (filteredResult) => emit(state.copyWith(status: RequestState.success, products: filteredResult, hasReachedMax: filteredResult.isEmpty)),
      );
    }
  }
}
