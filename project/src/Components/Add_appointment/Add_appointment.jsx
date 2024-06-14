import React from 'react'
import '../Sign_up/SignUpForm.css'
import './Add_appointment.css'
import '../Logmenu/WhiteRec.css'
import logo from '../Images/logo.png';

function Add_appointment () {
  return (
    <div className='blue-rectangle1'>
    <div className='add_appointment_white-rectangle1'>
    <div className='Add_appointment_logo_Container'>
    <img src={logo} alt="Logo" className="appointment_logo"/>
    <p className='Add_appointment_Optimize-text'>Siva Health Hub</p>
    </div>

    </div>
    </div>
  )
}

export default Add_appointment
