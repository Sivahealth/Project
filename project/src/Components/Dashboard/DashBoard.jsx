import './DashBoard.css';
import React, {  useEffect } from 'react';
import logo from '../Images/logonoback.png';
import D_dashboard from './D-dashboard';
import D_activities from './D-activities';
import D_users from './D-users';
import D_calendar from './D-calendar';
import D_messages from './D-messages';
import D_payments from './D-payments';
import D_reports from './D-reports';
import Newpatient_chart from './Newpatient_chart';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';

function DashBoard () {
    useEffect(() => {
        // Add class to body when component mounts
        document.body.classList.add('dashboard-background');
        
    
        // Remove class from body when component unmounts
        return () => {
          document.body.classList.remove('dashboard-background');
          
        };
      }, []);

  return (
    <div className='maindash'>
    <div className='logo_dash'>
      <img src={logo} alt="Logonoback" className="logo1"/>
      </div>
    <div className='sidebar'>
    <div className='dashboardlogoname'>
    <p className='Optimize-text3'><Link to="/dashboard" className='custom_link'>Siva Health Hub</Link></p>
    </div>
    <D_dashboard/>
    <D_activities/>
    <D_users/>
    <D_reports/>
    <D_calendar/>
    <D_messages/>
    <D_payments/>
    </div>
    <div className='Whitecontainer'>
    <Newpatient_chart/>
    </div>
     
    </div>
  )
}

export default DashBoard
