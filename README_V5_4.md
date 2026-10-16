# Supervisión 360° V5.4

## Cambios
- Acceso flotante al asistente con sugerencias. Es un asistente de reglas y solo lectura; no es todavía IA generativa.
- Hora local visible junto al estado de Supabase.
- Google Maps integrado en cada ficha con coordenadas verificadas o enlace de búsqueda cuando no existen. **No se inventan ubicaciones ni se realiza geocodificación automática**.
- Mejoras de transición y de interfaz.
- PWA instalable desde Chrome/Edge: Instalación → Abrir como ventana.

## Publicación
Reemplazá los archivos del repositorio GitHub por los del ZIP, conservando tu configuración de Netlify. La aplicación usa `config.js` con **únicamente la clave publicable**, nunca una clave secreta.

## Privacidad
El sitio Netlify es accesible públicamente por URL, aunque el repositorio GitHub sea privado. La información de las escuelas requiere acceso autenticado y RLS. **Verificá las políticas antes de usar datos reales sensibles.** Nunca subir documentos nominales o sensibles de menores a repositorios ni a la caché local.

## Sin conexión
La PWA conserva los archivos de interfaz para mejorar el arranque tras haberla abierto online, pero **Supabase y el inicio de sesión necesitan internet**, al igual que Google Maps. **Esta versión no es un modo offline de datos** y no almacena fichas sensibles en el navegador. Una versión offline real requerirá almacenamiento local cifrado, sincronización con conflictos y controles de sesión.

## Pendientes
- Confirmar la matrícula cargada y los 29 registros en producción.
- Cargar y verificar direcciones y coordenadas de cada establecimiento.
- Tablas/permisos específicos para fondos, documentos, cooperadora y casos socioeducativos.
