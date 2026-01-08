import { useState, useEffect } from 'react'

const API_URL = 'http://localhost:8000'

function App() {
  const [expenses, setExpenses] = useState([])
  const [description, setDescription] = useState('')
  const [amount, setAmount] = useState('')
  const [category, setCategory] = useState('food')

  // ============================================
  // FEAT-002: Load expenses (IMPLEMENTED)
  // ============================================
  useEffect(() => {
    fetchExpenses()
  }, [])

  const fetchExpenses = async () => {
    try {
      const res = await fetch(`${API_URL}/expenses`)
      const data = await res.json()
      setExpenses(data)
    } catch (err) {
      console.error('Error fetching expenses:', err)
    }
  }

  // ============================================
  // FEAT-001: Create expense (IMPLEMENTED)
  // ============================================
  const handleSubmit = async (e) => {
    e.preventDefault()
    if (!description || !amount) return

    try {
      const res = await fetch(`${API_URL}/expenses`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          description,
          amount: parseFloat(amount),
          category
        })
      })

      if (res.ok) {
        setDescription('')
        setAmount('')
        fetchExpenses()
      }
    } catch (err) {
      console.error('Error creating expense:', err)
    }
  }

  // ============================================
  // FEAT-005: Delete expense (TODO)
  // ============================================
  const handleDelete = async (id) => {
    // TODO: Implement delete
    // 1. Call DELETE /expenses/{id}
    // 2. If successful, refresh the list
    alert('Delete not implemented yet!')
  }

  const total = expenses.reduce((sum, e) => sum + e.amount, 0)

  return (
    <div className="container">
      <h1>Expense Tracker</h1>

      <form className="form" onSubmit={handleSubmit}>
        <input
          type="text"
          placeholder="Description"
          value={description}
          onChange={(e) => setDescription(e.target.value)}
        />
        <input
          type="number"
          placeholder="Amount"
          step="0.01"
          value={amount}
          onChange={(e) => setAmount(e.target.value)}
        />
        <select value={category} onChange={(e) => setCategory(e.target.value)}>
          <option value="food">Food</option>
          <option value="transport">Transport</option>
          <option value="entertainment">Entertainment</option>
          <option value="utilities">Utilities</option>
          <option value="other">Other</option>
        </select>
        <button type="submit">Add Expense</button>
      </form>

      <div className="expense-list">
        {expenses.length === 0 ? (
          <div className="empty">No expenses yet. Add one above!</div>
        ) : (
          <>
            {expenses.map((expense) => (
              <div key={expense.id} className="expense-item">
                <div className="expense-info">
                  <div className="expense-description">{expense.description}</div>
                  <div className="expense-category">{expense.category}</div>
                </div>
                <div className="expense-amount">${expense.amount.toFixed(2)}</div>
                <button className="delete-btn" onClick={() => handleDelete(expense.id)}>
                  X
                </button>
              </div>
            ))}
            <div className="total">Total: ${total.toFixed(2)}</div>
          </>
        )}
      </div>
    </div>
  )
}

export default App
