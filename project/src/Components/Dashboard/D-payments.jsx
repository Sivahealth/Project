import React from 'react'
import './DashBoard.css'
import plogo from '../Images/payments_logo.png';

function D_payments() {
  return (
    <div className='D_payments'>
    <div className='dashboardmenu'>
    <img src={plogo} alt="payments-logo" className="dlogo1"/>
    <div className='dashboard_menu_container'>
      <p className='dashboard-text'>Payments</p>
    </div>
    </div>
    </div>
  )
}

export default D_payments