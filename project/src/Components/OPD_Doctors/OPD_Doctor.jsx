import '../Activities/Activities.css';
import '../Dashboard/DashBoard.css'
import './OPD_Doctor.css'
import React, { useEffect,useState } from 'react';
import logo from '../Images/logonoback.png';
import Lilogo from '../Images/Left_icon.png';
import Searchbar_OPD from './Searchbar_OPD';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';

function OPD_Doctor() {
  const [appointments, setAppointments] = useState([]);
  const [filteredAppointments, setFilteredAppointments] = useState(appointments);
  const [doctors, setDoctors] = useState([]);
  const [selectedDate, setSelectedDate] = useState('');
  const [department, setDepartment] = useState('OPD');

  useEffect(() => {
    document.body.classList.add('activities-background');
    return () => {
      document.body.classList.remove('activities-background');
    };
  }, []);

  /*useEffect(() => {
    if (selectedDate) {
      fetchDoctors(department, selectedDate);
    }
  }, [selectedDate, department]);*/

 /* const fetchDoctors = async (dept, date) => {
    try {
      const response = await fetch(`http://localhost:8002/api/doctors?department=${dept}&date=${date}`);
      const data = await response.json();
      setDoctors(Array.isArray(data) ? data : []);
    } catch (error) {
      console.error('Error fetching doctors:', error);
    }
  };

  const fetchAvailableSlots = async (doctorId) => {
    try {
      const response = await fetch(`http://localhost:8002/api/doctors/${doctorId}/slots?date=${selectedDate}`);
      const data = await response.json();
      return Array.isArray(data) ? data : [];
    } catch (error) {
      console.error('Error fetching available slots:', error);
      return [];
    }
  };*/



  const fetchDoctorsByDate = async (date) => {
    try {
      const response = await fetch('http://localhost:8002/api/doctors/by-date', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ availableDate: date }),
      });
      const data = await response.json();
      setDoctors(data);
    } catch (error) {
      console.error('Error fetching doctors:', error);
    }
  };

  /*const handleDateChange = (event) => {
    setSelectedDate(event.target.value);
  };*/

  const handleDateChange = (event) => {
    const date = event.target.value;
    setSelectedDate(date);
    fetchDoctorsByDate(date);
  };
/*
  const DoctorCard = ({ doctor, selectedDate }) => {
  const [availableSlots, setAvailableSlots] = useState([]);

  useEffect(() => {
    if (selectedDate) {
      const slots = doctor.availableTime.split(','); // Split the availableTime string into an array
      setAvailableSlots(slots);
    }
  }, [selectedDate, doctor]);

  return (
    <div className="doctor-card">
      <h2>{doctor.name}</h2>
      <div className="departmentname">Department: {doctor.department}</div>
      <select>
        <option value="" disabled>Select a time slot</option>
        {availableSlots.map(slot => (
          <option key={slot} value={slot}>{slot}</option>
        ))}
      </select>
    </div>
  );
};*/
const DoctorCard = ({ doctor }) => {
  const availableSlots = doctor.availableTime.split(',');

  return (
    <div className="doctor-card">
      <h2>{doctor.name}</h2>
      <select>
        <option value="" disabled>Select a time slot</option>
        {availableSlots.map((slot, index) => (
          <option key={index} value={slot}>{slot}</option>
        ))}
      </select>
    </div>
  );
};


  return (
    <div className='maindash'>
      <div className='logo_dash'>
        <img src={logo} alt="Logonoback" className="logo1" />
      </div>
      <div className='acsidebar'>
        <div className='dashboardlogoname'>
          <p className='Optimize-text3'><Link to="/dashboard" className='custom_link'>Siva Health Hub</Link></p>
        </div>
        <div className='back'>
          <div className='activitiesmenu'>
            <img src={Lilogo} alt="dashboard-logo" className="aclogo1" />
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
        <Searchbar_OPD placeholder="Search Doctor's Name..." handleSearch={(term) => {
          const filtered = appointments.filter((item) =>
            item.appointment.toLowerCase().includes(term.toLowerCase())
          );
          setFilteredAppointments(filtered);
        }} />
        <div className='selectdata'>
          <div>
            <label htmlFor="appointment-date">Select Date: </label>
            <input
              type="date"
              id="appointment-date"
              value={selectedDate}
              onChange={handleDateChange}
            />
          </div>
          <div className='doctordata'>
            {doctors.map(doctor => (
              <DoctorCard
                key={doctor._id}
                doctor={doctor}
               /* selectedDate={selectedDate}*/
               
              />
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}

export default OPD_Doctor;