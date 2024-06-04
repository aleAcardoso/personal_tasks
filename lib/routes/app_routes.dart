enum AppRoutes {
  initialScreen,
  formScreen;

  String get route =>
      switch (this) {
        AppRoutes.initialScreen => '/initial_screen',
        AppRoutes.formScreen => '/form_screen'
      };
}