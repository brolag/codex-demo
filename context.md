# Expense Tracker — Contexto del Sistema

## 1. Estructura del proyecto
- Raíz del repo orientada a dos servicios: `backend/` (API FastAPI) y `frontend/` (React + Vite).
- Archivos de control del bucle autónomo: `prd.json` (estado de features) y `progress.txt` (log de iteraciones).
- Calidad e instrucciones del agente en `AGENTS.md`; documentación del loop en `README.md` y `scripts/README.md`.
- Scripts de automatización del loop en `scripts/` y `ralph.sh`.
- Tests backend en `backend/test_main.py`; dependencias Python en `backend/requirements.txt`.
- Entrypoint frontend en `frontend/src/main.jsx` con la vista principal en `frontend/src/App.jsx` y estilos en `frontend/src/index.css`.

## 2. Arquitectura
- Patrón simple de servicio REST sin capas separadas: un único módulo `backend/main.py` con FastAPI, almacenamiento en memoria (lista global `expenses`) y modelos Pydantic para entrada/salida.
- Frontend monocasco en React (Vite) que consume directamente la API mediante `fetch`; estado local con hooks (`useState`, `useEffect`).
- No hay persistencia externa ni capas de dominio/repositorio; el diseño está optimizado para un demo educativo del ciclo Ralph (iteraciones pequeñas, pruebas dirigidas).

## 3. Stack tecnológico
- Backend: Python 3.10+, FastAPI 0.109, Pydantic 2.5, Uvicorn 0.27, Pytest para tests.
- Frontend: React 18 con Vite 5, sin librerías de estado global ni UI adicionales.
- CORS configurado para `http://localhost:5173` (puerto dev de Vite).

## 4. Funcionalidades principales
- feat-001 (Hecho): Crear gasto `POST /expenses` con descripción, monto y categoría; genera `id` UUID corto y `created_at`.
- feat-002 (Hecho): Listar gastos `GET /expenses`.
- feat-003 a feat-007 (Pendiente en backend, pruebas marcadas con `@pytest.mark.skip`): obtener por id, actualizar, eliminar (también frontend), filtrar por categoría y estadísticas por categoría.
- Frontend refleja creación y listado; eliminación está esqueleto con `alert` pendiente de implementar.

## 5. Flujos de datos
- Creación: formulario React → `POST /expenses` → API añade a `expenses` y responde con objeto `Expense`; frontend limpia campos y recarga lista.
- Listado: `useEffect` inicial llama `GET /expenses`; respuesta JSON se guarda en estado `expenses` y se muestra con total calculado en cliente.
- El flujo esperado (aún no implementado) para delete/update/filters/stats seguirá el mismo patrón: llamadas `fetch` a endpoints REST y actualización del estado local.
- Tests limpian `expenses` antes de cada caso para garantizar aislamiento.

## 6. Dependencias e integraciones
- Sin base de datos ni servicios externos; almacenamiento solo en memoria de proceso.
- Sin SDKs externos en frontend; solo `fetch` nativo.
- Integraciones de tooling: scripts de loop Ralph (`scripts/*.sh`, `ralph.sh`) orquestan iteraciones automáticas que leen `prd.json`/`progress.txt`.

## 7. Configuración
- Backend: ejecutable con `uvicorn main:app --reload` desde `backend/`; CORS abierto al frontend local. No se usan variables de entorno.
- Frontend: Vite (`npm run dev`) en puerto 5173; `API_URL` hardcodeado a `http://localhost:8000` en `frontend/src/App.jsx`.
- Tests: `cd backend && pytest -v`; fixtures limpian estado global.
- Dependencias: `pip install -r backend/requirements.txt`; `npm install` en `frontend/`.

## 8. Contexto de decisiones
- Diseño intencionalmente minimalista para demostrar el patrón Ralph Wiggum: un solo archivo de API, estado en memoria y pruebas guía por feature (`prd.json`/`progress.txt` marcan progreso).
- FastAPI elegido por rapidez para exponer REST + validación Pydantic; Vite+React para montar rápidamente una UI ligera.
- Inexistencia de persistencia o capas adicionales reduce fricción en iteraciones educativas y facilita reseteo de estado entre tests.
