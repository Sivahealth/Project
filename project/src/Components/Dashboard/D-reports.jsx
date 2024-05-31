import React from 'react'
import './DashBoard.css'
import rlogo from '../Images/reports_logo.png';

function D_reports() {
  return (
    <div className='D_reports'>
    <div className='dashboardmenu'>
    <img src={rlogo} alt="reports-logo" className="dlogo1"/>
    <div className='dashboard_menu_container'>
      <p className='dashboard-text'>Reports</p>
    </div>
    </div>
    </div>
  )
}

export default D_reports