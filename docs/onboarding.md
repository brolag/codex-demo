# Onboarding y puesta en marcha

Guia para instalar y ejecutar el Expense Tracker en local. Escrita como checklist de onboarding tecnico.

## Prerrequisitos
- Python 3.10+ y `pip`
- Node.js 18+ y `npm`
- Bash/zsh para los scripts del repo

## Vista rapida del proyecto
- `backend/`: API FastAPI con almacenamiento en memoria (`main.py`, tests en `test_main.py`, deps en `requirements.txt`).
- `frontend/`: React + Vite (`src/App.jsx` usa `API_URL` apuntando a `http://localhost:8000`).
- `prd.json` y `progress.txt`: control de features y log de iteraciones.
- `scripts/` y `ralph.sh`: bucle autonomo Ralph Wiggum (opcional).

## Backend: instalacion y ejecucion
1) `cd backend`
2) Crear y activar entorno virtual:
   - Unix/macOS: `python3 -m venv venv && source venv/bin/activate`
   - Windows: `python -m venv venv && venv\\Scripts\\activate`
3) Instalar deps: `pip install -r requirements.txt`
4) Correr en modo desarrollo: `uvicorn main:app --reload --port 8000`
5) Probar salud: `curl http://localhost:8000/health` debe devolver `{"status":"ok"}`
6) Notas:
   - CORS ya permite `http://localhost:5173` (frontend dev).
   - Almacenamiento es en memoria; reiniciar borra los datos.

## Backend: tests
- Ejecuta: `cd backend && pytest -v`
- Los tests limpian la lista `expenses` antes de cada caso.

## Frontend: instalacion y ejecucion
1) `cd frontend`
2) Instalar deps: `npm install`
3) Correr dev server: `npm run dev` (escucha en `http://localhost:5173`)
4) Abrir en navegador y verificar que la lista inicial esta vacia.
5) Si el backend no esta en `http://localhost:8000`, ajusta `API_URL` en `src/App.jsx`.

## Flujo basico para verificar
1) Inicia backend (puerto 8000) y frontend (puerto 5173).
2) En la UI agrega un gasto con descripcion, monto y categoria.
3) Confirma que aparece en la lista y que el total se actualiza.
4) Observa la consola backend si necesitas trazas; los datos se pierden al reiniciar.

## Opcional: bucle Ralph Wiggum
- Para practicar el loop autonomo: `chmod +x ralph.sh` y ejecuta `./ralph.sh 1` (o usa scripts en `scripts/` para modos HITL/AFK).
- El loop lee `prd.json` y `progress.txt` y ejecuta iteraciones de una sola feature.

## Problemas comunes
- **Versiones**: si falta un modulo, revisa que el entorno virtual este activo y `pip install -r requirements.txt` haya corrido sin errores.
- **Puertos**: si cambias el puerto del backend, ajusta `allow_origins` en `backend/main.py` y `API_URL` en el frontend.
- **Estado**: como es en memoria, los datos desaparecen al reiniciar; esto es esperado para el demo.

