import React from 'react'
import './DashBoard.css'
import mlogo from '../Images/messages_logo.png';

function D_messages() {
  return (
    <div className='D_messages'>
    <div className='dashboardmenu'>
    <img src={mlogo} alt="messages-logo" className="dlogo1"/>
    <div className='dashboard_menu_container'>
      <p className='dashboard-text'>Messages</p>
    </div>
    </div>
    </div>
  )
}

export default D_messages