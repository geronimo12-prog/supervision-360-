# Supervisión 360° — V5 · Supabase + GitHub Pages

Esta versión **no usa datos ficticios ni localStorage como base de datos**. Requiere un proyecto real de Supabase y acceso autorizado. Incluye directorio, ficha por escuela, mapa por escuela, modificación de datos institucionales, agenda persistida y asistente local de lectura de registros (NO IA de escritura todavía).

## Pasos en orden

1. En [Supabase](https://supabase.com/dashboard), crear un proyecto **nuevo**. No utilizar una base existente con datos importantes sin revisar antes las migraciones.
2. SQL Editor → **New query** → ejecutar `supabase/01_escuelas_relevamiento.sql` (crea tablas e inserta 29 escuelas con matrícula del relevamiento de junio).
3. SQL Editor → ejecutar `supabase/02_acceso_y_agenda.sql` (añade usuarios autorizados, políticas RLS y agenda).
4. Authentication → Users → **Add user**: crear cuenta de Silvia con email y contraseña segura. Deshabilitar registros públicos en Authentication → Providers → Email si corresponde. Copiar UUID del usuario.
5. SQL Editor → ejecutar, reemplazando el UUID por el real:
   ```sql
   insert into public.supervision_usuarios(usuario_id,nombre)
   values ('UUID-REAL-DE-SILVIA', 'Silvia')
   on conflict(usuario_id) do nothing;
   ```
6. En Supabase → **Project Settings → API** (o Connect, según interfaz), copiar la URL del proyecto y la clave **publishable / anon**. **Nunca copiar `service_role`, `secret`, ni password PostgreSQL** al sitio.
7. Duplicar `config.example.js` como `config.js`, editar la URL y la clave pública. `config.js` está en `.gitignore`: si elegís GitHub Pages, necesitás publicar una copia con los datos públicos del proyecto, mediante una variable de CI o un archivo generado en el despliegue. La URL y la clave publishable no son secretos: la seguridad depende de las políticas RLS.
8. Para prueba local, ejecutar `INICIAR_SUPERVISION_360.bat` con Python instalado. Abrir `http://localhost:8787`.
9. Para publicar en GitHub Pages, creá un repositorio privado o público y subí el contenido de esta carpeta. **GitHub Pages puede publicar los archivos aunque el repositorio sea privado**, según plan; no subas ningún PDF nominal de alumnos, ni archivos de datos internos. En **Settings → Pages** activá el despliegue desde la rama o GitHub Actions. La carpeta publicada necesita `config.js`: podés agregar en tu repo un workflow que genere ese archivo desde variables de GitHub (`SUPABASE_URL` y `SUPABASE_ANON_KEY`) al construir y publicar. Alternativamente para la primera prueba pública, podés commitear `config.js` solo con URL y clave *publishable* (no secret) si entendés que serán visibles.
10. Abrí el enlace HTTPS de Pages en Chrome o Edge y usá **Instalar aplicación** (o `⋮ → Transmitir, guardar y compartir → Instalar página como aplicación` según versión). En iPhone Safari: **Compartir → Añadir a pantalla de inicio**.

## Importante

- GitHub almacena el **código**, Supabase guarda los **datos** y GitHub Pages sirve la **aplicación web**.
- La V5 no incluye datos identificables de alumnos ni intervenciones socioeducativas, que necesitan autorizaciones y seguridad adicional.
- Cada escuela incluye sección de fondos/documentación reservada para próximas migraciones. No se declara implementado lo que todavía no está.
- El SQL utiliza `ON CONFLICT` y conserva registros existentes; aun así, hacé respaldo antes de reejecutarlo sobre una base modificada.
- Dos informes del año 2026 pueden mostrar distintas cifras porque tienen diferentes fechas; no reemplazar automáticamente el relevamiento histórico.
- Si se actualizan datos en el editor de Supabase, pulsá recargar en el navegador para traer los cambios.

## V5.1: arranque corregido

`config.js` ahora viene incluido con valores de ejemplo. Al abrir, la aplicación muestra “Configuración pendiente” hasta que reemplaces ambos valores. Cuando los completes, se descargará la biblioteca pública de Supabase. Si la descarga o autenticación falla, la pantalla informará del error en lugar de quedar permanentemente cargando.

IMPORTANTE: `config.js` sigue excluido de Git por `.gitignore`. En GitHub Pages hay que generar ese archivo durante el despliegue o incluir la configuración pública (nunca una clave secreta). El sitio no se conecta a tu proyecto por sí solo.
