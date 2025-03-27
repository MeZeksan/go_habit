class EnvConfig {
  // Url Supabase
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL',
      defaultValue: 'https://dpukebvrkxkqyitxiozj.supabase.co');

  //Anon Supabase
  static const String supabaseAnonKey = String.fromEnvironment(
      'SUPABASE_ANON_KEY',
      defaultValue:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxpbmx6ZnJvcWVuZ2tudWppY2N3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI5MTEzNDEsImV4cCI6MjA1ODQ4NzM0MX0.XgbLx-L6aOJWuX3rAAlU_HCkj3tX0Oddsbxw4pJ6Im0');
}
