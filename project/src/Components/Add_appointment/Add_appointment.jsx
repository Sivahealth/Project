import React, { useState } from 'react';
import './Add_appointment.css'
import '../Logmenu/WhiteRec.css'
import logo from '../Images/logo.png';

function Add_appointment () {

  const [selectedDepartment, setSelectedDepartment] = useState('');

  const handleNavigation = (e) => {
    e.preventDefault();
    if (selectedDepartment) {
      window.location.href = `/${selectedDepartment}_doctor`;
    }
  }

  return (
    <div className='blue-rectangle1'>
    <div className='add_appointment_white-rectangle1'>
    <div className='Add_appointment_logo_Container'>
    <img src={logo} alt="Logo" className="appointment_logo"/>
    <p className='Add_appointment_Optimize-text'>Siva Health Hub</p>
    </div>
    <div className='appointment_text_container'>
      <p className='appointment-title'>Your appointment schedule</p>
    <form>
      <div className="input-group2">
            <label htmlFor="text" className="label2">Patient's Name</label>
            <input type="text1" id="username" name="username" placeholder='First Name'required />
      </div>
      <div className="input-group3">
             <input type="text2" id="username" name="username" placeholder='Last Name'required />
      </div>
       <div className="dob-group">
       <label htmlFor="text" className="label2">Date of Birth</label>
       <input type="text1" id="username" name="username" placeholder='Date'required />
       </div>

       <div className="dob-group1">
       <input type="text2" id="username" name="username" placeholder='Month'required />
       </div>
       
       <div className="dob-group2">
       <input type="text2" id="username" name="username" placeholder='Year'required />
       </div>

       <div className="gender-group">
       <label htmlFor="text1" className="label2">Gender</label>
       <select className="select1" id="gender" name="gender" required>
              <option value="" disabled selected></option>
              <option value="male">Male</option>
              <option value="female">Female</option>
            </select>
       </div>

      <div className="age-group">
      <label htmlFor="text1" className="label2">Age</label>
      <input type="text1" id="username" name="username" required />
      </div>
     
     <div className="mail-group">
     <label htmlFor="text1" className="label3">E-mail</label>
     <input type="text1" id="username" name="username" placeholder='myname@example.com'required />
     </div>

    <div className="address-group">
    <label htmlFor="text1" className="label3">Address</label>
    <input type="text1" id="username" name="username" required />
    </div>

    <div className="city-group">
    <input type="text2" id="username" name="username" placeholder='City'required />
    </div>

    <div className="province-group">
    <input type="text2" id="username" name="username" placeholder='Province'required />
    </div>

    <div className='select-depatment'>
    
    <select id="Department" name="Department" value={selectedDepartment} onChange={(e) => setSelectedDepartment(e.target.value)}  required>
                  <option value="" disabled>Select Department</option>
                  <option value="OPD">OPD</option>
                  <option value="Physiotherapy">Physiotherapy</option>
                  <option value="Occupational_therapy">Occupational Therapy</option>
                  <option value="Speech_therapy">Speech Therapy</option>
                  <option value="Homevisits_councelling">Homevisits and Councelling</option>
                  <option value="Elderly_care">Elderly Care</option>
                  <option value="Homecare_nursing">Homecare Nursing</option>
                  <option value="Post_surgical_care">Post Surgical Care</option>
                  <option value="Laboratory_services">Laboratory Services</option>
    </select>
    </div>

    <div className='contact-group'>
    <input type="text2" id="username" name="username" placeholder='Contact Number'required />
    </div>

      </form>
    <div className="label4">
      Which department would you like to  get appointment from ?
    </div>
    </div>

    <div className='label5'>
      Appointment date and time, <a href="#" onClick={(e) => handleNavigation(e)} >click here</a>.
    </div>

    <div className='button-container'>
    <button type="submit" className="submit-button">Book an Appointment</button>
    </div>

    </div>
    </div>
  )
}

export default Add_appointment
