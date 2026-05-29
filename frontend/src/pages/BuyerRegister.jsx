import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { motion } from 'framer-motion'
import { UserPlus, ShoppingBag, Mail, Lock, Eye, EyeOff, Phone, User, ArrowRight } from 'lucide-react'
import toast from 'react-hot-toast'
import api from '../utils/api'
import { login } from '../utils/auth'

export default function BuyerRegister() {
  const navigate = useNavigate()
  const [form, setForm] = useState({ full_name: '', email: '', phone: '', password: '', confirm_password: '' })
  const [loading, setLoading] = useState(false)
  const [showPassword, setShowPassword] = useState(false)
  const [showConfirm, setShowConfirm] = useState(false)

  const handleSubmit = async (e) => {
    e.preventDefault()
    if (form.password !== form.confirm_password) return toast.error('Passwords do not match')
    if (form.password.length < 6) return toast.error('Password must be at least 6 characters')
    setLoading(true)
    try {
      const res = await api.post('/auth/register', { ...form, role: 'buyer' })
      login(res.data.token, res.data.user)
      toast.success('Welcome to MarketNest!')
      navigate('/')
    } catch (err) {
      toast.error(err.response?.data?.message || 'Registration failed')
    } finally {
      setLoading(false)
    }
  }

  const features = [
    { icon: '🛍️', text: 'Shop from 10,000+ products' },
    { icon: '🔒', text: 'Secure & fast checkout' },
    { icon: '🚚', text: 'Delivery across Pakistan' },
    { icon: '⭐', text: 'Verified sellers only' },
  ]

  const inputStyle = {
    width: '100%',
    padding: '0.75rem 0.875rem 0.75rem 2.75rem',
    border: '1.5px solid #E8E6E1',
    borderRadius: 10,
    fontSize: '0.9rem',
    background: '#FAFAF8',
    color: '#111',
    transition: 'border-color 0.2s, box-shadow 0.2s',
    boxSizing: 'border-box',
  }

  const labelStyle = {
    display: 'block',
    fontSize: '0.82rem',
    fontWeight: 600,
    color: '#374151',
    marginBottom: '0.4rem',
    letterSpacing: '0.01em',
  }

  const iconWrap = {
    position: 'absolute',
    left: 12,
    top: '50%',
    transform: 'translateY(-50%)',
    color: '#9CA3AF',
    display: 'flex',
    alignItems: 'center',
  }

  const passwordStrength = () => {
    const p = form.password
    if (!p) return null
    if (p.length < 6) return { label: 'Too short', color: '#EF4444', width: '25%' }
    if (p.length < 8) return { label: 'Weak', color: '#F59E0B', width: '50%' }
    if (p.length < 12) return { label: 'Good', color: '#10B981', width: '75%' }
    return { label: 'Strong', color: '#059669', width: '100%' }
  }
  const strength = passwordStrength()

  return (
    <div style={{ minHeight: '100vh', display: 'grid', gridTemplateColumns: '1fr 420px', fontFamily: "'Inter', sans-serif" }}>

      {/* ── Left Panel (form) ── */}
      <div style={{
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        background: '#F7F6F3',
        padding: '2rem',
        overflowY: 'auto',
      }}>
        <motion.div
          initial={{ opacity: 0, x: -30 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.5 }}
          style={{ width: '100%', maxWidth: 480 }}
        >
          {/* Logo */}
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.6rem', marginBottom: '2rem' }}>
            <div style={{
              width: 38, height: 38, borderRadius: 10,
              background: 'linear-gradient(135deg, #C8973A, #A67C2E)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              boxShadow: '0 4px 12px rgba(200,151,58,0.35)',
            }}>
              <ShoppingBag size={20} color="white" />
            </div>
            <span style={{ fontSize: '1.1rem', fontWeight: 800, color: '#1A1A2E', letterSpacing: '-0.02em' }}>
              Market<span style={{ color: '#C8973A' }}>Nest</span>
            </span>
          </div>

          {/* Header */}
          <div style={{ marginBottom: '1.75rem' }}>
            <div style={{
              display: 'inline-flex',
              alignItems: 'center',
              gap: '0.4rem',
              background: 'rgba(200,151,58,0.08)',
              border: '1px solid rgba(200,151,58,0.18)',
              borderRadius: 20,
              padding: '0.3rem 0.875rem',
              marginBottom: '0.875rem',
            }}>
              <UserPlus size={13} color="#C8973A" />
              <span style={{ color: '#C8973A', fontSize: '0.78rem', fontWeight: 600 }}>Buyer Registration</span>
            </div>
            <h1 style={{ fontSize: '1.8rem', fontWeight: 800, color: '#111', marginBottom: '0.35rem', letterSpacing: '-0.02em' }}>
              Create your account
            </h1>
            <p style={{ color: '#6B7280', fontSize: '0.9rem' }}>
              Join MarketNest and start shopping today
            </p>
          </div>

          {/* Form */}
          <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>

            {/* Name + Phone */}
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '0.875rem' }}>
              <div>
                <label style={labelStyle}>Full Name *</label>
                <div style={{ position: 'relative' }}>
                  <span style={iconWrap}><User size={15} /></span>
                  <input
                    style={inputStyle}
                    type="text"
                    placeholder="Your full name"
                    value={form.full_name}
                    onChange={e => setForm({ ...form, full_name: e.target.value })}
                    required
                    onFocus={e => { e.target.style.borderColor = '#C8973A'; e.target.style.boxShadow = '0 0 0 3px rgba(200,151,58,0.1)' }}
                    onBlur={e => { e.target.style.borderColor = '#E8E6E1'; e.target.style.boxShadow = 'none' }}
                  />
                </div>
              </div>
              <div>
                <label style={labelStyle}>Phone Number *</label>
                <div style={{ position: 'relative' }}>
                  <span style={iconWrap}><Phone size={15} /></span>
                  <input
                    style={inputStyle}
                    type="tel"
                    placeholder="03XXXXXXXXX"
                    value={form.phone}
                    onChange={e => setForm({ ...form, phone: e.target.value })}
                    required
                    onFocus={e => { e.target.style.borderColor = '#C8973A'; e.target.style.boxShadow = '0 0 0 3px rgba(200,151,58,0.1)' }}
                    onBlur={e => { e.target.style.borderColor = '#E8E6E1'; e.target.style.boxShadow = 'none' }}
                  />
                </div>
              </div>
            </div>

            {/* Email */}
            <div>
              <label style={labelStyle}>Email Address *</label>
              <div style={{ position: 'relative' }}>
                <span style={iconWrap}><Mail size={15} /></span>
                <input
                  style={inputStyle}
                  type="email"
                  placeholder="you@email.com"
                  value={form.email}
                  onChange={e => setForm({ ...form, email: e.target.value })}
                  required
                  onFocus={e => { e.target.style.borderColor = '#C8973A'; e.target.style.boxShadow = '0 0 0 3px rgba(200,151,58,0.1)' }}
                  onBlur={e => { e.target.style.borderColor = '#E8E6E1'; e.target.style.boxShadow = 'none' }}
                />
              </div>
            </div>

            {/* Password */}
            <div>
              <label style={labelStyle}>Password *</label>
              <div style={{ position: 'relative' }}>
                <span style={iconWrap}><Lock size={15} /></span>
                <input
                  style={{ ...inputStyle, paddingRight: '2.75rem' }}
                  type={showPassword ? 'text' : 'password'}
                  placeholder="Min 6 characters"
                  value={form.password}
                  onChange={e => setForm({ ...form, password: e.target.value })}
                  required
                  onFocus={e => { e.target.style.borderColor = '#C8973A'; e.target.style.boxShadow = '0 0 0 3px rgba(200,151,58,0.1)' }}
                  onBlur={e => { e.target.style.borderColor = '#E8E6E1'; e.target.style.boxShadow = 'none' }}
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  style={{ position: 'absolute', right: 12, top: '50%', transform: 'translateY(-50%)', background: 'none', border: 'none', cursor: 'pointer', color: '#9CA3AF', display: 'flex', padding: 0 }}
                >
                  {showPassword ? <EyeOff size={16} /> : <Eye size={16} />}
                </button>
              </div>
              {/* Password strength */}
              {strength && (
                <div style={{ marginTop: '0.4rem' }}>
                  <div style={{ height: 3, background: '#E8E6E1', borderRadius: 2, overflow: 'hidden' }}>
                    <div style={{ height: '100%', width: strength.width, background: strength.color, borderRadius: 2, transition: 'width 0.3s, background 0.3s' }} />
                  </div>
                  <span style={{ fontSize: '0.72rem', color: strength.color, fontWeight: 600, marginTop: '0.2rem', display: 'block' }}>{strength.label}</span>
                </div>
              )}
            </div>

            {/* Confirm Password */}
            <div>
              <label style={labelStyle}>Confirm Password *</label>
              <div style={{ position: 'relative' }}>
                <span style={iconWrap}><Lock size={15} /></span>
                <input
                  style={{
                    ...inputStyle,
                    paddingRight: '2.75rem',
                    borderColor: form.confirm_password && form.confirm_password !== form.password ? '#EF4444' : '#E8E6E1',
                  }}
                  type={showConfirm ? 'text' : 'password'}
                  placeholder="Repeat password"
                  value={form.confirm_password}
                  onChange={e => setForm({ ...form, confirm_password: e.target.value })}
                  required
                  onFocus={e => { e.target.style.borderColor = '#C8973A'; e.target.style.boxShadow = '0 0 0 3px rgba(200,151,58,0.1)' }}
                  onBlur={e => {
                    e.target.style.borderColor = form.confirm_password && form.confirm_password !== form.password ? '#EF4444' : '#E8E6E1'
                    e.target.style.boxShadow = 'none'
                  }}
                />
                <button
                  type="button"
                  onClick={() => setShowConfirm(!showConfirm)}
                  style={{ position: 'absolute', right: 12, top: '50%', transform: 'translateY(-50%)', background: 'none', border: 'none', cursor: 'pointer', color: '#9CA3AF', display: 'flex', padding: 0 }}
                >
                  {showConfirm ? <EyeOff size={16} /> : <Eye size={16} />}
                </button>
              </div>
              {form.confirm_password && form.confirm_password !== form.password && (
                <p style={{ fontSize: '0.75rem', color: '#EF4444', marginTop: '0.25rem' }}>Passwords do not match</p>
              )}
            </div>

            {/* Divider */}
            <div style={{ borderTop: '1px solid #E8E6E1', margin: '0.25rem 0' }} />

            {/* Submit */}
            <button
              type="submit"
              disabled={loading}
              style={{
                width: '100%',
                padding: '0.875rem',
                background: loading ? '#D1CEC8' : 'linear-gradient(135deg, #C8973A, #A67C2E)',
                color: 'white',
                border: 'none',
                borderRadius: 12,
                fontSize: '0.95rem',
                fontWeight: 700,
                cursor: loading ? 'not-allowed' : 'pointer',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                gap: '0.5rem',
                boxShadow: loading ? 'none' : '0 4px 16px rgba(200,151,58,0.35)',
                transition: 'all 0.2s',
              }}
            >
              {loading ? (
                <>
                  <div style={{ width: 16, height: 16, border: '2px solid rgba(255,255,255,0.3)', borderTopColor: 'white', borderRadius: '50%', animation: 'spin 0.7s linear infinite' }} />
                  Creating account...
                </>
              ) : (
                <>
                  <UserPlus size={17} />
                  Create Account
                  <ArrowRight size={16} />
                </>
              )}
            </button>

            {/* Bottom links */}
            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.4rem', textAlign: 'center' }}>
              <p style={{ fontSize: '0.875rem', color: '#6B7280' }}>
                Already have an account?{' '}
                <Link to="/buyer/login" style={{ color: '#C8973A', fontWeight: 600, textDecoration: 'none' }}>Sign in</Link>
              </p>
              <p style={{ fontSize: '0.875rem', color: '#6B7280' }}>
                Want to sell?{' '}
                <Link to="/seller/register" style={{ color: '#1A1A2E', fontWeight: 600, textDecoration: 'none' }}>Register as Seller →</Link>
              </p>
            </div>
          </form>
        </motion.div>
      </div>

      {/* ── Right Panel ── */}
      <div style={{
        background: 'linear-gradient(160deg, #1A1A2E 0%, #16213E 55%, #0F3460 100%)',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        padding: '3rem 2.5rem',
        position: 'relative',
        overflow: 'hidden',
      }}>
        <div style={{ position: 'absolute', top: -80, left: -80, width: 300, height: 300, borderRadius: '50%', background: 'rgba(200,151,58,0.07)', pointerEvents: 'none' }} />
        <div style={{ position: 'absolute', bottom: -60, right: -60, width: 240, height: 240, borderRadius: '50%', background: 'rgba(200,151,58,0.05)', pointerEvents: 'none' }} />

        <motion.div initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.6 }} style={{ textAlign: 'center', zIndex: 1 }}>
          <div style={{
            width: 76, height: 76, borderRadius: 22,
            background: 'linear-gradient(135deg, #C8973A, #A67C2E)',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            margin: '0 auto 1.75rem',
            boxShadow: '0 8px 32px rgba(200,151,58,0.4)',
          }}>
            <ShoppingBag size={38} color="white" />
          </div>

          <h2 style={{ color: 'white', fontSize: '1.6rem', fontWeight: 800, marginBottom: '0.75rem', letterSpacing: '-0.03em' }}>
            Shop smarter on<br />
            <span style={{ color: '#C8973A' }}>MarketNest</span>
          </h2>
          <p style={{ color: 'rgba(255,255,255,0.45)', fontSize: '0.875rem', lineHeight: 1.7, maxWidth: 260, margin: '0 auto 2.5rem' }}>
            Pakistan's trusted marketplace with thousands of verified sellers and products.
          </p>

          {/* Features */}
          <div style={{ display: 'flex', flexDirection: 'column', gap: '0.875rem', textAlign: 'left' }}>
            {features.map((f, i) => (
              <motion.div
                key={i}
                initial={{ opacity: 0, x: 20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: 0.2 + i * 0.08 }}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.75rem',
                  padding: '0.7rem 1rem',
                  borderRadius: 12,
                  background: 'rgba(255,255,255,0.04)',
                  border: '1px solid rgba(255,255,255,0.07)',
                }}
              >
                <span style={{ fontSize: '1.2rem' }}>{f.icon}</span>
                <span style={{ color: 'rgba(255,255,255,0.7)', fontSize: '0.85rem', fontWeight: 500 }}>{f.text}</span>
              </motion.div>
            ))}
          </div>
        </motion.div>
      </div>

      <style>{`
        @keyframes spin { to { transform: rotate(360deg); } }
        input::placeholder { color: #C4C0BB; }
      `}</style>
    </div>
  )
}
