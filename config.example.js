// Copiá a config.js. La clave publicable / anon es segura en el navegador SOLO con RLS correctamente aplicado.
// NUNCA escribas una clave service_role, secret key ni contraseña PostgreSQL aquí.
window.SUPERVISION_CONFIG = {
  supabaseUrl: 'https://TU-PROYECTO.supabase.co',
  supabaseAnonKey: 'TU-CLAVE-PUBLICABLE-O-ANON'
};
