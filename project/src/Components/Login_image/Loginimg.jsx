import React from 'react';
import loginImage from '../Images/login_image.png'; // Adjust the path as needed

import './Loginimg.css'; // Import the CSS file


const Loginimg = () => {
  return (
    <div>
      <img src={loginImage} alt="Login" className="login" />
      
    </div>
  );
};

export default Loginimg;
