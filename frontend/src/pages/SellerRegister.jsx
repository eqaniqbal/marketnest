import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { motion } from 'framer-motion'
import { Store, User, Mail, Phone, MapPin, CreditCard, Lock, Eye, EyeOff, ArrowRight, CheckCircle } from 'lucide-react'
import toast from 'react-hot-toast'
import api from '../utils/api'
import { login } from '../utils/auth'

export default function SellerRegister() {
  const navigate = useNavigate()
  const [form, setForm] = useState({
    full_name: '', email: '', phone: '', password: '',
    store_name: '', business_address: '', bank_details: ''
  })
  const [loading, setLoading] = useState(false)
  const [showPassword, setShowPassword] = useState(false)
  const [step, setStep] = useState(1)

  const handleSubmit = async (e) => {
    e.preventDefault()
    setLoading(true)
    try {
      const res = await api.post('/auth/register', { ...form, role: 'seller' })
      login(res.data.token, res.data.user)
      toast.success('Seller account created!')
      navigate('/seller/dashboard')
    } catch (err) {
      toast.error(err.response?.data?.message || 'Registration failed')
    } finally {
      setLoading(false)
    }
  }

  const perks = [
    { icon: '📦', title: 'List Unlimited Products', desc: 'No cap on your catalog size' },
    { icon: '📊', title: 'Real-time Analytics', desc: 'Track sales, views & revenue' },
    { icon: '💬', title: 'Chat with Buyers', desc: 'Built-in messaging system' },
    { icon: '💰', title: 'Fast Payouts', desc: 'Weekly transfers to your bank' },
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

  return (
    <div style={{
      minHeight: '100vh',
      display: 'grid',
      gridTemplateColumns: '420px 1fr',
      fontFamily: "'Inter', sans-serif",
    }}>

      {/* ── Left Panel ── */}
      <div style={{
        background: 'linear-gradient(160deg, #1A1A2E 0%, #16213E 50%, #0F3460 100%)',
        display: 'flex',
        flexDirection: 'column',
        padding: '3rem 2.5rem',
        position: 'relative',
        overflow: 'hidden',
      }}>
        {/* Decorative blobs */}
        <div style={{ position: 'absolute', top: -80, right: -80, width: 300, height: 300, borderRadius: '50%', background: 'rgba(200,151,58,0.08)', pointerEvents: 'none' }} />
        <div style={{ position: 'absolute', bottom: -60, left: -60, width: 240, height: 240, borderRadius: '50%', background: 'rgba(200,151,58,0.05)', pointerEvents: 'none' }} />
        <div style={{ position: 'absolute', top: '45%', left: '50%', transform: 'translate(-50%,-50%)', width: 180, height: 180, borderRadius: '50%', background: 'rgba(200,151,58,0.04)', pointerEvents: 'none' }} />

        {/* Logo */}
        <motion.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.5 }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', marginBottom: '3rem' }}>
            <div style={{
              width: 42, height: 42, borderRadius: 12,
              background: 'linear-gradient(135deg, #C8973A, #A67C2E)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              boxShadow: '0 4px 16px rgba(200,151,58,0.4)',
            }}>
              <Store size={22} color="white" />
            </div>
            <span style={{ color: 'white', fontSize: '1.2rem', fontWeight: 800, letterSpacing: '-0.02em' }}>
              Market<span style={{ color: '#C8973A' }}>Nest</span>
            </span>
          </div>
        </motion.div>

        {/* Headline */}
        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.6, delay: 0.1 }} style={{ flex: 1 }}>
          <h2 style={{ color: 'white', fontSize: '1.75rem', fontWeight: 800, lineHeight: 1.25, marginBottom: '0.75rem', letterSpacing: '-0.03em' }}>
            Start selling on<br />
            <span style={{ color: '#C8973A' }}>Pakistan's #1</span><br />
            marketplace
          </h2>
          <p style={{ color: 'rgba(255,255,255,0.45)', fontSize: '0.88rem', lineHeight: 1.7, marginBottom: '2.5rem' }}>
            Join thousands of sellers reaching millions of buyers across Pakistan.
          </p>

          {/* Perks */}
          <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
            {perks.map((perk, i) => (
              <motion.div
                key={i}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ duration: 0.4, delay: 0.2 + i * 0.08 }}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.875rem',
                  padding: '0.75rem 1rem',
                  borderRadius: 12,
                  background: 'rgba(255,255,255,0.04)',
                  border: '1px solid rgba(255,255,255,0.07)',
                }}
              >
                <span style={{ fontSize: '1.3rem' }}>{perk.icon}</span>
                <div>
                  <div style={{ color: 'white', fontSize: '0.85rem', fontWeight: 600 }}>{perk.title}</div>
                  <div style={{ color: 'rgba(255,255,255,0.4)', fontSize: '0.76rem' }}>{perk.desc}</div>
                </div>
              </motion.div>
            ))}
          </div>
        </motion.div>

        {/* Bottom link */}
        <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} transition={{ delay: 0.7 }} style={{ marginTop: '2rem' }}>
          <p style={{ color: 'rgba(255,255,255,0.35)', fontSize: '0.8rem' }}>
            Already have an account?{' '}
            <Link to="/seller/login" style={{ color: '#C8973A', fontWeight: 600, textDecoration: 'none' }}>
              Sign in →
            </Link>
          </p>
        </motion.div>
      </div>

      {/* ── Right Panel ── */}
      <div style={{
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        background: '#F7F6F3',
        padding: '2rem',
        overflowY: 'auto',
      }}>
        <motion.div
          initial={{ opacity: 0, x: 30 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.5 }}
          style={{ width: '100%', maxWidth: 500 }}
        >
          {/* Header */}
          <div style={{ marginBottom: '2rem' }}>
            <div style={{
              display: 'inline-flex',
              alignItems: 'center',
              gap: '0.4rem',
              background: 'rgba(200,151,58,0.1)',
              border: '1px solid rgba(200,151,58,0.2)',
              borderRadius: 20,
              padding: '0.3rem 0.875rem',
              marginBottom: '1rem',
            }}>
              <Store size={13} color="#C8973A" />
              <span style={{ color: '#C8973A', fontSize: '0.78rem', fontWeight: 600 }}>Seller Registration</span>
            </div>
            <h1 style={{ fontSize: '1.8rem', fontWeight: 800, color: '#111', marginBottom: '0.35rem', letterSpacing: '-0.02em' }}>
              Create your store
            </h1>
            <p style={{ color: '#6B7280', fontSize: '0.9rem' }}>
              Fill in your details to start selling today
            </p>
          </div>

          {/* Form */}
          <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>

            {/* Store Name */}
            <div>
              <label style={labelStyle}>Store Name *</label>
              <div style={{ position: 'relative' }}>
                <span style={iconWrap}><Store size={15} /></span>
                <input
                  style={inputStyle}
                  type="text"
                  placeholder="Your store name"
                  value={form.store_name}
                  onChange={e => setForm({ ...form, store_name: e.target.value })}
                  required
                  onFocus={e => { e.target.style.borderColor = '#C8973A'; e.target.style.boxShadow = '0 0 0 3px rgba(200,151,58,0.1)' }}
                  onBlur={e => { e.target.style.borderColor = '#E8E6E1'; e.target.style.boxShadow = 'none' }}
                />
              </div>
            </div>

            {/* Two columns: Name + Phone */}
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '0.875rem' }}>
              <div>
                <label style={labelStyle}>Owner Name *</label>
                <div style={{ position: 'relative' }}>
                  <span style={iconWrap}><User size={15} /></span>
                  <input
                    style={inputStyle}
                    type="text"
                    placeholder="Full name"
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

            {/* Business Address */}
            <div>
              <label style={labelStyle}>Business Address *</label>
              <div style={{ position: 'relative' }}>
                <span style={iconWrap}><MapPin size={15} /></span>
                <input
                  style={inputStyle}
                  type="text"
                  placeholder="Street, City, Province"
                  value={form.business_address}
                  onChange={e => setForm({ ...form, business_address: e.target.value })}
                  required
                  onFocus={e => { e.target.style.borderColor = '#C8973A'; e.target.style.boxShadow = '0 0 0 3px rgba(200,151,58,0.1)' }}
                  onBlur={e => { e.target.style.borderColor = '#E8E6E1'; e.target.style.boxShadow = 'none' }}
                />
              </div>
            </div>

            {/* Bank Details */}
            <div>
              <label style={labelStyle}>
                Bank / Payout Details
                <span style={{ color: '#9CA3AF', fontWeight: 400, marginLeft: '0.3rem' }}>(optional)</span>
              </label>
              <div style={{ position: 'relative' }}>
                <span style={iconWrap}><CreditCard size={15} /></span>
                <input
                  style={inputStyle}
                  type="text"
                  placeholder="Bank name & account number"
                  value={form.bank_details}
                  onChange={e => setForm({ ...form, bank_details: e.target.value })}
                  onFocus={e => { e.target.style.borderColor = '#C8973A'; e.target.style.boxShadow = '0 0 0 3px rgba(200,151,58,0.1)' }}
                  onBlur={e => { e.target.style.borderColor = '#E8E6E1'; e.target.style.boxShadow = 'none' }}
                />
              </div>
              <p style={{ fontSize: '0.75rem', color: '#9CA3AF', marginTop: '0.3rem' }}>
                Used for processing your weekly payouts
              </p>
            </div>

            {/* Password */}
            <div>
              <label style={labelStyle}>Password *</label>
              <div style={{ position: 'relative' }}>
                <span style={iconWrap}><Lock size={15} /></span>
                <input
                  style={{ ...inputStyle, paddingRight: '2.75rem' }}
                  type={showPassword ? 'text' : 'password'}
                  placeholder="Minimum 6 characters"
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
                letterSpacing: '0.01em',
              }}
            >
              {loading ? (
                <>
                  <div style={{ width: 16, height: 16, border: '2px solid rgba(255,255,255,0.3)', borderTopColor: 'white', borderRadius: '50%', animation: 'spin 0.7s linear infinite' }} />
                  Creating account...
                </>
              ) : (
                <>
                  <Store size={17} />
                  Create Seller Account
                  <ArrowRight size={16} />
                </>
              )}
            </button>

            {/* Terms note */}
            <p style={{ textAlign: 'center', fontSize: '0.75rem', color: '#9CA3AF', lineHeight: 1.6 }}>
              By registering you agree to MarketNest's{' '}
              <span style={{ color: '#C8973A', cursor: 'pointer' }}>Terms of Service</span>
              {' '}and{' '}
              <span style={{ color: '#C8973A', cursor: 'pointer' }}>Seller Policy</span>
            </p>

            {/* Bottom links */}
            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.4rem', textAlign: 'center', marginTop: '0.25rem' }}>
              <p style={{ fontSize: '0.875rem', color: '#6B7280' }}>
                Already registered?{' '}
                <Link to="/seller/login" style={{ color: '#C8973A', fontWeight: 600, textDecoration: 'none' }}>
                  Seller Login
                </Link>
              </p>
              <p style={{ fontSize: '0.875rem', color: '#6B7280' }}>
                Want to shop instead?{' '}
                <Link to="/buyer/register" style={{ color: '#1A1A2E', fontWeight: 600, textDecoration: 'none' }}>
                  Buyer Registration →
                </Link>
              </p>
            </div>
          </form>
        </motion.div>
      </div>

      <style>{`
        @keyframes spin { to { transform: rotate(360deg); } }
        input::placeholder { color: #C4C0BB; }
      `}</style>
    </div>
  )
}
