import { useState } from 'react'
import axios from 'axios'

function App() {
  const [username, setUsername] = useState('')
  const [password, setPassword] = useState('')
  const [token, setToken] = useState('')
  const [productName, setProductName] = useState('')
  const [quantity, setQuantity] = useState(1)
  const [price, setPrice] = useState(1000)

  const API_BASE_URL = 'http://localhost:8080' // Gateway URL

  const handleSignUp = async () => {
    try {
      const res = await axios.post(`${API_BASE_URL}/api/v1/auth/signup`, { username, password, email: 'test@test.com' })
      alert(res.data)
    } catch (err) {
      alert(err.response?.data || 'Error')
    }
  }

  const handleLogin = async () => {
    try {
      const res = await axios.post(`${API_BASE_URL}/api/v1/auth/login`, { username, password })
      setToken(res.data)
      alert('Login Success!')
    } catch (err) {
      alert(err.response?.data || 'Error')
    }
  }

  const handleOrder = async () => {
    try {
      const res = await axios.post(`${API_BASE_URL}/api/v1/orders`, { productName, quantity, price })
      alert(res.data)
    } catch (err) {
      alert(err.response?.data || 'Error')
    }
  }

  return (
    <div style={{ padding: '20px' }}>
      <h1>MSA Sandbox Frontend</h1>
      
      <section>
        <h2>Auth Service</h2>
        <input placeholder="Username" value={username} onChange={e => setUsername(e.target.value)} />
        <input placeholder="Password" type="password" value={password} onChange={e => setPassword(e.target.value)} />
        <button onClick={handleSignUp}>Sign Up</button>
        <button onClick={handleLogin}>Login</button>
        {token && <p>Token: {token}</p>}
      </section>

      <hr />

      <section>
        <h2>Order Service</h2>
        <input placeholder="Product Name" value={productName} onChange={e => setProductName(e.target.value)} />
        <input type="number" value={quantity} onChange={e => setQuantity(Number(e.target.value))} />
        <input type="number" value={price} onChange={e => setPrice(Number(e.target.value))} />
        <button onClick={handleOrder}>Create Order</button>
      </section>
    </div>
  )
}

export default App