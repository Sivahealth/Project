import React from 'react'
import { BrowserRouter as Router, Route, Switch, Link, Routes, BrowserRouter } from 'react-router-dom'
import {Add_appointment, Calendar, Message, Payments, Reports, WhiteRec,OPD_Doctor,Physiotherapy_Doctor} from './Components'
import {SignUpForm} from './Components'
import {DashBoard} from './Components'
import {Activities} from './Components'
import {PatientList} from './Components'
import { Users } from './Components'
import './index.css';

const App = () => {
  return (
   <div>
    <BrowserRouter>
    <Routes>
      <Route index element={<WhiteRec/>}/>
      <Route path="/home" element={<WhiteRec/>}/>
      <Route path="/create" element={<SignUpForm/>}/>
      <Route path="/dashboard" element={<DashBoard/>}/>
      <Route path="/activities" element={<Activities/>}/>
      <Route path="/patientlist" element={<PatientList/>}/>
      <Route path="/users" element={<Users/>}/>
      <Route path="/calendar" element={<Calendar/>}/>
      <Route path="/message" element={<Message/>}/>
      <Route path="/payments" element={<Payments/>}/>
      <Route path="/reports" element={<Reports/>}/>
      <Route path="/new_appointment" element={<Add_appointment/>} />
      <Route path="/opd_doctor" element={<OPD_Doctor />} />
      <Route path="/physiotherapy_doctor" element={<Physiotherapy_Doctor />} />
    </Routes>
    
    </BrowserRouter>
    
   </div>
   

    
    
  )
}

export default App
