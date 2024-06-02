import './PatientList.css';
import '../Dashboard/DashBoard.css'
import React, { useEffect } from 'react';
import logo from '../Images/logonoback.png';
import NewMoppointments from './NewMoppointment';
import Newpatientlist from './Newpatientlist';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';

function PatientList () {
    useEffect(() => {
        // Add class to body when component mounts
        document.body.classList.add('patientlist-background');
        
    
        // Remove class from body when component unmounts
        return () => {
          document.body.classList.remove('patientlist-background');
          
        };
      }, []);

  return (
    <div className='maindash'>
    <div className='logo_dash'>
      <img src={logo} alt="Logonoback" className="logo1"/>
      </div>
    <div className='plsidebar'>
    <div className='dashboardlogoname'>
    <p className='Optimize-text3'><Link to="/dashboard" className='custom_link'>Siva Health Hub</Link></p>
    </div>
    <NewMoppointments/>
    <Newpatientlist/>
    </div>
    <div className='Whitecontainer'>
    </div>
     
    </div>
  )
}

export default PatientList
