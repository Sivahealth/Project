import './DashBoard.css';
import React from 'react'
import dlogo from '../Images/dashboard_logo.png';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';

function D_dashboard() {
  return (
    <div className='D_dashboard'>
    <div className='dashboardmenu'>
    <img src={dlogo} alt="dashboard-logo" className="dlogo1"/>
    <div className='dashboard_menu_container'>
      <p className='dashboard-text'><Link to="/dashboard" className='custom_link'>Dashboard</Link></p>
    </div>
    </div>
    </div>
  )
}
export default D_dashboard
