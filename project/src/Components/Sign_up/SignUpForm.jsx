import React from 'react';
import './SignUpForm.css';

const SignUpForm = () => {
  return (
    <div className='blue-rectangle1'>
    <div className='white-rectangle1'>
    <div className="root-container">
      <div className="signup-container">
      <p className='Optimize-text2'>Please log in using your employee credentials</p>
        <form>
          <div className="input-group">
            <label htmlFor="username" className="label">Username</label>
            <input type="text" id="username" name="username" required />
          </div>
          <div className="input-group">
            <label htmlFor="password" className="label">Password</label>
            <input type="password" id="password" name="password" required />
          </div>
          <div className="input-group">
            <label htmlFor="confirm-password" className="label">Confirm Password</label>
            <input type="password" id="confirm-password" name="confirm-password" required />
          </div>
          <button type="submit">Sign Up</button>
        </form>
        <div>
       <p className="backlink"> <a href="/home">Back to Home</a></p>
       </div>
      </div>
    </div>
    </div>
    </div>
  );
};

export default SignUpForm;
