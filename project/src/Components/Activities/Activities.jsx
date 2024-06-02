import './Activities.css';
import '../Dashboard/DashBoard.css'
import React, { useEffect } from 'react';
import logo from '../Images/logonoback.png';
import Moppointments from './Moppointment';
import Patientlist from './Patientlist';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';

function Activities () {
    useEffect(() => {
        // Add class to body when component mounts
        document.body.classList.add('activities-background');
        
    
        // Remove class from body when component unmounts
        return () => {
          document.body.classList.remove('activities-background');
          
        };
      }, []);

  return (
    <div className='maindash'>
    <div className='logo_dash'>
      <img src={logo} alt="Logonoback" className="logo1"/>
      </div>
    <div className='acsidebar'>
    <div className='dashboardlogoname'>
    <p className='Optimize-text3'><Link to="/dashboard" className='custom_link'>Siva Health Hub</Link></p>
    </div>
    <Moppointments/>
    <Patientlist/>
    </div>
    <div className='Whitecontainer'>
    </div>
     
    </div>
  )
}

export default Activities
