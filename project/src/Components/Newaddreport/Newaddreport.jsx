import React, { useState} from 'react';
import { useNavigate } from 'react-router-dom';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import '../Sign_up/SignUpForm.css';
import './Newaddreport.css';
import axios from 'axios';

const Newaddreport = () => {
  const [formData, setFormData] = useState({
        patientName: '',
        doctorName: '',
        contactNumber: '',
        totalCharge: '',
        attachedPdf:'',
  });

  const navigate = useNavigate();

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({
      ...formData,
      [name]: value
    });
  };
 

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    const reportData = {
        patientName:formData.patientName,
        doctorName:formData.doctorName,
        contactNumber:formData.contactNumber,
        totalCharge:formData.totalCharge,
        attachedPdf:formData.attachedPdf,
    };
    try {
      const response = await fetch('http://localhost:8002/api/reports', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(reportData),
      });

      if (response.ok) {
        // Handle successful booking
        console.log('Add the report details successfully!');
        alert('Add the report details successfully!');
        navigate('/reports');
        // Optionally clear form data after successful submission
        setFormData({
        patientName: '',
        doctorName: '',
        contactNumber: '',
        totalCharge: '',
        attachedPdf:'',
        });
      } else {
        // Handle error
        console.error('Failed to add report details');
      }
    } catch (error) {
      // Handle error
      console.error('Error:', error);
    }
  };



  return (
    <div className='blue-rectangle1'>
      <div className='white-rectangle1'>
        <div className="root-container">
          <div className="signup-container">
            <p className='Optimize-text2'>Please add report details</p>
            <form onSubmit={handleSubmit}>
              <div className="input-group5">
                <label htmlFor="patientName" className="label6">Patient Name</label>
                <input type="text" id="patientName" name="patientName" value={formData.patientName} onChange={handleChange} required />
              </div>
              <div className="input-group5">
                <label htmlFor="doctorName" className="label6">Doctor Name</label>
                <input type="text" id="doctorName" name="doctorName" value={formData.doctorName} onChange={handleChange} required />
              </div>
              <div className="input-group5">
                <label htmlFor="contactNumber" className="label6">Patient Contact Number</label>
                <input type="text" id="contactNumber" name="contactNumber" value={formData.contactNumber} onChange={handleChange} required />
              </div>
              <div className="input-group5">
                <label htmlFor="totalCharge" className="label6">Total Charge</label>
                <input type="text" id="totalCharge" name="totalCharge" value={formData.totalCharge} onChange={handleChange} required />
              </div>
              <div className="input-group5">
                <label htmlFor="attachedPdf" className="label6">Add report PDF link</label>
                <input type="text" id="attachedPdf" name="attachedPdf" value={formData.attachedPdf} onChange={handleChange} required />
              </div>
              <div className="white-rectangle2">
                <button type="submit">Submit</button>
                <div>
                  <p className="backlink"> <a href="/reports">To reports page</a></p>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Newaddreport;