/*import React from 'react';*/
import React, { useState } from 'react';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import './SignUpForm.css';

const SignUpForm = () => {
  const [startDate, setStartDate] = useState(null);
  return (
    <div className='blue-rectangle1'>
    <div className='white-rectangle1'>
    <div className="root-container">
      <div className="signup-container">
      <p className='Optimize-text2'>Please log in using your employee credentials</p>
        <form>
          <div className="input-group1">
            <label htmlFor="text" className="label1">First Name</label>
            <input type="text" id="username" name="username" required />
          </div>
          <div className="input-group1">
            <label htmlFor="text" className="label1">Last Name</label>
            <input type="text" id="username" name="username" required />
          </div>
          <div className="input-group1">
            <label htmlFor="text" className="label1">E-mail</label>
            <input type="text" id="username" name="username" required />
          </div>
          <div className="input-group1">
            <label htmlFor="text" className="label1">Gender</label>
            <select id="gender" name="gender" required>
              <option value="" disabled selected></option>
              <option value="male">Male</option>
              <option value="female">Female</option>
            </select>
          </div>
          <div className="input-group1">
            <label htmlFor="text" className="label1">Date of Birth</label>
            <DatePicker
              id="dob"
              selected={startDate}
              onChange={(date) => setStartDate(date)}
              dateFormat="dd/MM/yyyy"
              placeholderText="Select your date of birth"
              className="datepicker"
            />
          </div>
          <div className="input-group1">
            <label htmlFor="password" className="label1">Create Password</label>
            <input type="password" id="password" name="password" required />
          </div>
          <div className="input-group1">
            <label htmlFor="confirm-password" className="label1">Confirm Password</label>
            <input type="password" id="confirm-password" name="confirm-password" required />
          </div>
          <div className="white-rectangle2">
          <button type="submit">Create An Account</button>
            <div>
            <p className="backlink"> <a href="/home">Back to Home</a></p>
            </div>
          </div>
        </form>
      </div>
    </div>
    </div>
    </div>
  );
};

export default SignUpForm;
