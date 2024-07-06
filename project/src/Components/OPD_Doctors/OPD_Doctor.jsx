import '../Activities/Activities.css';
import '../Dashboard/DashBoard.css'
import './OPD_Doctor.css'
import React, { useEffect,useState } from 'react';
import logo from '../Images/logonoback.png';
import Lilogo from '../Images/Left_icon.png';
import Searchbar_OPD from './Searchbar_OPD';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';

function OPD_Doctor () {

    const [appointments, setAppointments] = useState([
      
    ]);
  
    const [filteredAppointments, setFilteredAppointments] = useState(appointments);
  
    const handleSearch = (searchTerm) => {
      const filtered = appointments.filter((item) =>
        item.appointment.toLowerCase().includes(searchTerm.toLowerCase())
      );
      setFilteredAppointments(filtered);
    };
  
  
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
  
        <div className='OPD_text_rectangle'>
         <div className='MA_text'>
                Welcome to OPD Department
          </div> 
        </div>
  
        <Searchbar_OPD placeholder="Search Doctor's Name..."  handleSearch={handleSearch}/>

      </div>
       
  
      </div>
    )
  }
  
  export default OPD_Doctor
  