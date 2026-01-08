import pytest
from fastapi.testclient import TestClient
from main import app, expenses

client = TestClient(app)

@pytest.fixture(autouse=True)
def clear_expenses():
    """Clear expenses before each test"""
    expenses.clear()

# ============================================
# FEAT-001: Create expense tests
# ============================================
class TestCreateExpense:
    def test_create_expense(self):
        response = client.post("/expenses", json={
            "description": "Lunch",
            "amount": 15.50,
            "category": "food"
        })
        assert response.status_code == 201
        data = response.json()
        assert data["description"] == "Lunch"
        assert data["amount"] == 15.50
        assert data["category"] == "food"
        assert "id" in data

    def test_create_expense_with_zero_amount(self):
        response = client.post("/expenses", json={
            "description": "Free sample",
            "amount": 0,
            "category": "food"
        })
        assert response.status_code == 201

# ============================================
# FEAT-002: List expenses tests
# ============================================
class TestListExpenses:
    def test_list_empty(self):
        response = client.get("/expenses")
        assert response.status_code == 200
        assert response.json() == []

    def test_list_with_expenses(self):
        client.post("/expenses", json={"description": "A", "amount": 10, "category": "food"})
        client.post("/expenses", json={"description": "B", "amount": 20, "category": "transport"})

        response = client.get("/expenses")
        assert response.status_code == 200
        assert len(response.json()) == 2

# ============================================
# FEAT-003: Get by ID tests (TODO)
# ============================================
class TestGetExpense:
    @pytest.mark.skip(reason="FEAT-003 not implemented")
    def test_get_expense_by_id(self):
        # Create expense first
        create_resp = client.post("/expenses", json={
            "description": "Test", "amount": 10, "category": "test"
        })
        expense_id = create_resp.json()["id"]

        # Get by ID
        response = client.get(f"/expenses/{expense_id}")
        assert response.status_code == 200
        assert response.json()["id"] == expense_id

    @pytest.mark.skip(reason="FEAT-003 not implemented")
    def test_get_nonexistent_expense(self):
        response = client.get("/expenses/nonexistent")
        assert response.status_code == 404

# ============================================
# FEAT-004: Update expense tests (TODO)
# ============================================
class TestUpdateExpense:
    @pytest.mark.skip(reason="FEAT-004 not implemented")
    def test_update_expense(self):
        create_resp = client.post("/expenses", json={
            "description": "Original", "amount": 10, "category": "food"
        })
        expense_id = create_resp.json()["id"]

        response = client.put(f"/expenses/{expense_id}", json={
            "description": "Updated",
            "amount": 25.00
        })
        assert response.status_code == 200
        assert response.json()["description"] == "Updated"
        assert response.json()["amount"] == 25.00

    @pytest.mark.skip(reason="FEAT-004 not implemented")
    def test_update_nonexistent(self):
        response = client.put("/expenses/fake", json={"description": "X"})
        assert response.status_code == 404

# ============================================
# FEAT-005: Delete expense tests (TODO)
# ============================================
class TestDeleteExpense:
    @pytest.mark.skip(reason="FEAT-005 not implemented")
    def test_delete_expense(self):
        create_resp = client.post("/expenses", json={
            "description": "To delete", "amount": 5, "category": "misc"
        })
        expense_id = create_resp.json()["id"]

        response = client.delete(f"/expenses/{expense_id}")
        assert response.status_code == 204

        # Verify deleted
        list_resp = client.get("/expenses")
        assert len(list_resp.json()) == 0

    @pytest.mark.skip(reason="FEAT-005 not implemented")
    def test_delete_nonexistent(self):
        response = client.delete("/expenses/fake")
        assert response.status_code == 404

# ============================================
# FEAT-006: Filter by category tests (TODO)
# ============================================
class TestFilterByCategory:
    @pytest.mark.skip(reason="FEAT-006 not implemented")
    def test_filter_by_category(self):
        client.post("/expenses", json={"description": "A", "amount": 10, "category": "food"})
        client.post("/expenses", json={"description": "B", "amount": 20, "category": "transport"})
        client.post("/expenses", json={"description": "C", "amount": 15, "category": "food"})

        response = client.get("/expenses/category/food")
        assert response.status_code == 200
        assert len(response.json()) == 2

# ============================================
# FEAT-007: Stats by category tests (TODO)
# ============================================
class TestStatsByCategory:
    @pytest.mark.skip(reason="FEAT-007 not implemented")
    def test_stats_by_category(self):
        client.post("/expenses", json={"description": "A", "amount": 10, "category": "food"})
        client.post("/expenses", json={"description": "B", "amount": 20, "category": "transport"})
        client.post("/expenses", json={"description": "C", "amount": 15, "category": "food"})

        response = client.get("/stats/by-category")
        assert response.status_code == 200
        data = response.json()
        assert data["food"] == 25.0
        assert data["transport"] == 20.0
