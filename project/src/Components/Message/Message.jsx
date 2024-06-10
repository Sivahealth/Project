import '../Activities/Activities.css';
import './Message.css';
import '../Dashboard/DashBoard.css';
import React, { useEffect } from 'react';
import logo from '../Images/logonoback.png';
import Lilogo from '../Images/Left_icon.png';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';
import Messagemenu from './Messagemenu';


function Massage(){
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
    <Messagemenu/>

    <div className='back'>
    <div className='activitiesmenu'>
    <img src={Lilogo} alt="dashboard-logo" className="aclogo1"/>
    <div className='activities_menu_container'>
      <p className='activities-text'><Link to="/dashboard" className='custom_link'>Back to menu</Link></p>
    </div>
    </div>
    </div>




    </div>
    <div className='Whitecontainer'>
    </div>
     
    </div>
  )
}

export default Massage