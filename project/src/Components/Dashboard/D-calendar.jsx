import React from 'react'
import './DashBoard.css'
import clogo from '../Images/calendar_logo.png';

function D_calendar() {
  return (
    <div className='D_calendar'>
    <div className='dashboardmenu'>
    <img src={clogo} alt="calendar-logo" className="dlogo1"/>
    <div className='dashboard_menu_container'>
      <p className='dashboard-text'>Calendar</p>
    </div>
    </div>
    </div>
  )
}

export default D_calendar