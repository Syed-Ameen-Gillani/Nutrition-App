import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  int index;

  NavigationCubit(this.index) : super(0);

  void navigateToTab(int newIndex) {
    index = newIndex;
    emit(index);
  }
}
// class NavigationCubit extends Cubit<int> {
//   final PageController pageController;

//   NavigationCubit()
//       : pageController = PageController(initialPage: 0),
//         super(0); // Start with the first tab (index 0)

//   void navigateToTab(int index) {
//     pageController.jumpToPage(index); // Jump to the desired tab
//     emit(index); // Change the state for the bottom navigation bar
//   }

//   @override
//   Future<void> close() {
//     pageController.dispose(); // Dispose the controller when Cubit is closed
//     return super.close();
//   }
// }
