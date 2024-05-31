import './DashBoard.css';
import React from 'react'
import ulogo from '../Images/Users_logo.png';

function D_users() {
  return (
    <div className='D_users'>
    <div className='dashboardmenu'>
    <img src={ulogo} alt="users-logo" className="dlogo1"/>
    <div className='dashboard_menu_container'>
      <p className='dashboard-text'>Users</p>
    </div>
    </div>
    </div>
  )
}
export default D_users