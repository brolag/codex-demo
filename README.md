# Expense Tracker 🧾

Demo de un rastreador de gastos con API en FastAPI y frontend en React + Vite, usado para practicar el ciclo autónomo Ralph Wiggum (iteraciones cortas, una feature a la vez).

- [Características](#características-principales)
- [Tecnologías](#tecnologías-utilizadas)
- [Arquitectura](#arquitectura)
- [Prerequisitos](#prerequisitos)
- [Instalación](#instalación)
- [Variables de entorno](#variables-de-entorno)
- [Cómo ejecutar](#cómo-ejecutar)
- [Estructura del proyecto](#estructura-del-proyecto)
- [API Endpoints](#api-endpoints)
- [Scripts disponibles](#scripts-disponibles)
- [Contribución](#contribución)
- [Troubleshooting](#troubleshooting)

## Características principales
- ✅ Crear gasto `POST /expenses` con `description`, `amount`, `category`.
- ✅ Listar gastos `GET /expenses`.
- 🔜 Obtener gasto por ID, actualizar, eliminar, filtrar por categoría, estadísticas por categoría (features planeadas en `prd.json`).
- Frontend React muestra lista, total y formulario de alta; eliminación aún pendiente en UI.

## Tecnologías utilizadas
- Backend: FastAPI 0.109, Pydantic 2.5, Uvicorn 0.27, Python 3.10+.
- Testing backend: Pytest 7.4.
- Frontend: React 18, Vite 5.
- Tooling: Scripts del bucle Ralph (`ralph.sh`, `scripts/*.sh`).

## Arquitectura
Servicio REST minimalista sin capas adicionales:
- API en un solo módulo (`backend/main.py`) con almacenamiento en memoria (lista global `expenses`).
- Frontend monocasco en React que consume la API vía `fetch` y maneja estado con hooks.
- Sin base de datos ni servicios externos; pensado para iterar rápido en demos y pruebas.

## Prerequisitos
- Python 3.10+ y `pip`.
- Node.js 18+ y `npm`.
- Bash/zsh para los scripts de automatización (opcional).

## Instalación
1. Clona el repositorio y entra al directorio.
2. **Backend**
   ```bash
   cd backend
   python3 -m venv venv
   source venv/bin/activate   # Windows: venv\Scripts\activate
   pip install -r requirements.txt
   ```
3. **Frontend**
   ```bash
   cd frontend
   npm install
   ```

## Variables de entorno
No se requieren por defecto; valores están hardcodeados para el demo. Si necesitas configurarlas, usa esta plantilla:

```bash
# backend/.env (opcional)
BACKEND_PORT=8000
BACKEND_HOST=0.0.0.0
ALLOW_ORIGINS=http://localhost:5173

# frontend/.env (opcional)
VITE_API_URL=http://localhost:8000
```

## Cómo ejecutar
**Desarrollo**
- Backend: `cd backend && uvicorn main:app --reload --port 8000`
- Frontend: `cd frontend && npm run dev` (abre `http://localhost:5173`)

**Producción (básico)**
- Backend: `cd backend && uvicorn main:app --host 0.0.0.0 --port 8000`
- Frontend: `cd frontend && npm run build && npm run preview` (o sirve `dist/` con tu servidor preferido)

**Testing**
- Backend: `cd backend && pytest -v`

## Estructura del proyecto
<details>
<summary>Ver árbol</summary>

```
.
├── backend/               # API FastAPI (main.py, tests, deps)
│   ├── main.py            # Endpoints y almacenamiento en memoria
│   ├── test_main.py       # Pruebas Pytest (algunas skip en TODO)
│   └── requirements.txt
├── frontend/              # React + Vite
│   ├── src/App.jsx        # UI principal (listar/crear gastos)
│   ├── src/main.jsx       # Entrypoint Vite
│   └── src/index.css      # Estilos básicos
├── prd.json               # Lista de features con estado (passes true/false)
├── progress.txt           # Log de iteraciones del ciclo Ralph
├── AGENTS.md              # Instrucciones de calidad para agentes
├── ralph.sh               # Script del loop autónomo
└── scripts/               # Variantes HITL/AFK del loop
```
</details>

## API Endpoints
- `GET /health` → `{"status": "ok"}`
- `POST /expenses` → Crea gasto. Body: `{description, amount, category}`. Responde `201` con gasto + `id` y `created_at`.
- `GET /expenses` → Lista de gastos.
- `GET /expenses/{expense_id}` → 🔜 Obtener por ID (pendiente).
- `PUT /expenses/{expense_id}` → 🔜 Actualizar gasto (pendiente).
- `DELETE /expenses/{expense_id}` → 🔜 Eliminar gasto (pendiente).
- `GET /expenses/category/{category}` → 🔜 Filtrar por categoría (pendiente).
- `GET /stats/by-category` → 🔜 Totales por categoría (pendiente).

## Scripts disponibles
- `npm run dev` (frontend) → Servidor Vite.
- `npm run build` (frontend) → Build de producción.
- `npm run preview` (frontend) → Previsualizar build.
- `ralph.sh` y `scripts/*.sh` → Ejecutan el loop Ralph Wiggum en modos HITL/AFK (lee `prd.json` y `progress.txt`).
- `codex custom onboard-expense` (Codex) → Onboarding interactivo con checklist de prerequisitos, setup y uso de Ralph/Codex.

## Contribución
1. Crea una rama a partir de `main`.
2. Implementa **una sola feature** a la vez (ver `prd.json`), empezando por backend y luego frontend.
3. Quita `@pytest.mark.skip` de la prueba asociada cuando implementes la feature.
4. Ejecuta `cd backend && pytest -v` antes de abrir PR.
5. Actualiza `progress.txt` con lo realizado.

## Troubleshooting
- ⚠️ **Dependencias faltantes**: verifica que el virtualenv esté activado y corre `pip install -r requirements.txt`.
- ⚠️ **CORS**: si cambias el puerto del frontend, ajusta `allow_origins` en `backend/main.py` (o `ALLOW_ORIGINS` si usas .env).
- ⚠️ **Puertos ocupados**: modifica `BACKEND_PORT`/`VITE_API_URL` según disponibilidad.
- ℹ️ **Estado perdido**: los datos viven en memoria; reiniciar el backend borra los gastos (comportamiento esperado en el demo).
