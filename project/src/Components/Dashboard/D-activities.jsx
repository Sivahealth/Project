import React from 'react'
import './DashBoard.css'
import alogo from '../Images/activities_logo.png';

function D_activities() {
  return (
    <div className='D_activities'>
    <div className='dashboardmenu'>
    <img src={alogo} alt="activities-logo" className="dlogo1"/>
    <div className='dashboard_menu_container'>
      <p className='dashboard-text'>Activities</p>
    </div>
    </div>
    </div>
  )
}

export default D_activities
