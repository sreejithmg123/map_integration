sealed class AppState {
  String text = 'text';
}

class LoadingState extends AppState {}

class LoadedState extends AppState {}

class ErrorState extends AppState {}
