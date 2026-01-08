from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import Optional
from datetime import datetime
import uuid

app = FastAPI(title="Expense Tracker API")

# CORS for React frontend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Models
class ExpenseCreate(BaseModel):
    description: str
    amount: float
    category: str

class ExpenseUpdate(BaseModel):
    description: Optional[str] = None
    amount: Optional[float] = None
    category: Optional[str] = None

class Expense(BaseModel):
    id: str
    description: str
    amount: float
    category: str
    created_at: datetime

# In-memory storage
expenses: list[Expense] = []

# Health check
@app.get("/health")
def health():
    return {"status": "ok"}

# ============================================
# FEAT-001: Create expense (IMPLEMENTED)
# ============================================
@app.post("/expenses", status_code=201)
def create_expense(expense: ExpenseCreate) -> Expense:
    new_expense = Expense(
        id=str(uuid.uuid4())[:8],
        description=expense.description,
        amount=expense.amount,
        category=expense.category,
        created_at=datetime.now()
    )
    expenses.append(new_expense)
    return new_expense

# ============================================
# FEAT-002: List expenses (IMPLEMENTED)
# ============================================
@app.get("/expenses")
def list_expenses() -> list[Expense]:
    return expenses

# ============================================
# FEAT-003: Get expense by ID (TODO)
# ============================================
@app.get("/expenses/{expense_id}")
def get_expense(expense_id: str):
    # TODO: Implement this endpoint
    # 1. Find expense by id
    # 2. If found, return it
    # 3. If not found, raise HTTPException(404)
    raise HTTPException(status_code=501, detail="Not implemented")

# ============================================
# FEAT-004: Update expense (TODO)
# ============================================
@app.put("/expenses/{expense_id}")
def update_expense(expense_id: str, update: ExpenseUpdate):
    # TODO: Implement this endpoint
    # 1. Find expense by id
    # 2. Update fields from ExpenseUpdate
    # 3. Return updated expense
    # 4. If not found, raise HTTPException(404)
    raise HTTPException(status_code=501, detail="Not implemented")

# ============================================
# FEAT-005: Delete expense (TODO)
# ============================================
@app.delete("/expenses/{expense_id}", status_code=204)
def delete_expense(expense_id: str):
    # TODO: Implement this endpoint
    # 1. Find expense by id
    # 2. Remove from list
    # 3. Return 204 (no content)
    # 4. If not found, raise HTTPException(404)
    raise HTTPException(status_code=501, detail="Not implemented")

# ============================================
# FEAT-006: Filter by category (TODO)
# ============================================
@app.get("/expenses/category/{category}")
def get_by_category(category: str):
    # TODO: Implement this endpoint
    # Return all expenses matching the category
    raise HTTPException(status_code=501, detail="Not implemented")

# ============================================
# FEAT-007: Get total by category (TODO)
# ============================================
@app.get("/stats/by-category")
def stats_by_category():
    # TODO: Implement this endpoint
    # Return dict with category totals: {"food": 150.0, "transport": 50.0}
    raise HTTPException(status_code=501, detail="Not implemented")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
