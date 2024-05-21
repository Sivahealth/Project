import React from 'react'
import './WhiteRec.css';
import logo from '../Images/logo.png';
import loginImage from '../Images/login_image.png';
import { Link } from 'react-router-dom';

const WhiteRec = () => {
  return (
  <div className='blue-rectangle'>
     <img src={loginImage} alt="Login" className="login" />
    <div className='white-rectangle'>

      <img src={logo} alt="Logo" className="logo"/>
      <div className='Container'>
      <p className='Optimize-text'>Siva Health Hub</p>
      <p className='Optimize-text1'>Please log in using your employee credentials</p>
      </div>

    <div className="login-container">
      <form>
        <div className="input-group">
          <label htmlFor="username">Username:</label>
          <input type="text" id="username" name="username" required />
        </div>
        <div className="input-group">
          <label htmlFor="password">Password:</label>
          <input type="password" id="password" name="password" required />
        </div>
        <button type="submit">Login</button>
      </form>
      <div>
      <p className="login-link"> <a href="/create">Don't have an account</a></p>
      </div>
    </div>
    </div>
 </div>






  )
}

export default WhiteRec
