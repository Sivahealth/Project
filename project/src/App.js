import React from 'react'
import { BrowserRouter as Router, Route, Switch, Link, Routes, BrowserRouter } from 'react-router-dom'
import {WhiteRec} from './Components'
import {SignUpForm} from './Components'

const App = () => {
  return (
   <div>
    <BrowserRouter>
    <Routes>
      <Route index element={<WhiteRec/>}/>
      <Route path="/home" element={<WhiteRec/>}/>
      <Route path="/create" element={<SignUpForm/>}/>
    </Routes>
    
    </BrowserRouter>
    
   </div>
   

    
    
  )
}

export default App
