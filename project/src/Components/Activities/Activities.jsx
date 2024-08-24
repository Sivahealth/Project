import './Activities.css';
import '../Dashboard/DashBoard.css'
import React, { useEffect,useState } from 'react';
import logo from '../Images/logonoback.png';
import Moppointments from './Moppointment';
import Patientlist from './Patientlist';
import Addappointment from './Addappointment';
import Lilogo from '../Images/Left_icon.png';
import Searchbar from './Searchbar';
import axios from 'axios';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';

function Activities () {

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

      useEffect(() => {
        // Fetch appointments from the backend
        axios.get('http://localhost:8002/api/')
          .then(response => setAppointments(response.data))
          .catch(error => console.error('Error fetching appointments:', error));
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

      <div className='MA_text_rectangle'>
       <div className='MA_text'>
              Manage Appointments
        </div> 
      </div>

      <Searchbar placeholder="Search appointments..."  handleSearch={handleSearch}/>
      <Addappointment/>
      <div className='Table_container'>
      <table>
        <thead>
          <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Phone Number</th>
            <th>Appointment Date & Time</th>
            <th>Status</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          {appointments.map(appointment => (
            <tr key={appointment._id}>
              <td>{appointment.firstName}</td>
              <td>{appointment.lastName}</td>
              <td>{appointment.contactNumber}</td>
              <td>{new Date(appointment.appointmentDate).toLocaleString()}</td>
              <td>{appointment.status}
              <div className="button-group">
              <button className="view-btn">View</button>
              </div>
              </td>
              <td>
              <div className="button-group">
                <button className="pay-now-btn">Pay Now</button>
                <button className="book-now-btn">Book Now</button>
              </div>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
      </div>
    </div>
     

    </div>
  )
}

export default Activities
