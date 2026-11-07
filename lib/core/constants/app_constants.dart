class AppConstants {
  // Supabase Configuration
  static const String supabaseUrl =
      'https://ykvyosjmsinhkotvhgbs.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlrdnlvc2ptc2luaGtvdHZoZ2JzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTQwNDY3ODIsImV4cCI6MjEwOTYyMjc4Mn0.K1_N1glPJuoRWL3I6zxI7Sj_avuYVPEt5Dp2begCUhU';

  // Table Names
  static const String restaurantsTable = 'restaurants';

  // Currencies list for onboarding
  static const List<String> supportedCurrencies = [
    'USD (\$)',
    'EUR (€)',
    'GBP (£)',
    'CAD (\$)',
    'AUD (\$)',
    'AED (د.إ)',
    'PKR (Rs.)',
  ];
}
