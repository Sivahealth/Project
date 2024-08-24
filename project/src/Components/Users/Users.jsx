import '../Activities/Activities.css';
import './Users.css';
import '../Dashboard/DashBoard.css';
import React, { useEffect,useState } from 'react';
import logo from '../Images/logonoback.png';
import Lilogo from '../Images/Left_icon.png';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';
import Usermenu from './Usermenu';
import Searchbar from '../Activities/Searchbar';
import axios from 'axios';

function Users(){
  const [users, setUsers] = useState([]);

        useEffect(() => {
        // Add class to body when component mounts
        document.body.classList.add('activities-background');
        
    
        // Remove class from body when component unmounts
        return () => {
          document.body.classList.remove('activities-background');
          
        };
      }, []);

      const handleSearch = (searchTerm) => {
      
      };

      useEffect(() => {
        // Fetch appointments from the backend
        axios.get('http://localhost:8002/api/users')
          .then(response => setUsers(response.data))
          .catch(error => console.error('Error fetching appointments:', error));
      }, []);

  return (
    <div className='maindash'>
    <div className='logo_dash'>
      <img src={logo} alt="Logonoback" className="logo1"/>
      </div>
    <div className='acsidebar'>
    <div className='dashboardlogoname'>
    <p className='Optimize-text3'><Link to="/dashboard" className='custom_link'>Siva Health Hub</Link></p>
    </div>
    <Usermenu/>

    <div className='back'>
    <div className='activitiesmenu'>
    <img src={Lilogo} alt="dashboard-logo" className="aclogo1"/>
    <div className='activities_menu_container'>
      <p className='activities-text'><Link to="/dashboard" className='custom_link'>Back to menu</Link></p>
    </div>
    </div>
    </div>




    </div>
    <div className='Whitecontainer'>
    <div className='MA_text_rectangle'>
       <div className='MA_text'>
              Users
        </div> 
      </div>
      <Searchbar placeholder="Search users..."  handleSearch={handleSearch}/>
      <div className='Table_container'>
      <table>
        <thead>
          <tr>
            <th>No</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Logged Date</th>
            <th>Logged Time</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
  {users.map((user, index) => {
    console.log(user); // Log user data for debugging

    const date = new Date(user.joinedTime);
  
    return (
      <tr key={user._id}>
        <td>{index + 1}</td>
        <td>{user.firstName}</td>
        <td>{user.lastName}</td>
        <td>{new Date(user.joinedAt).toLocaleDateString()}</td>
        <td>{user.joinedTime}</td>
        <td>
        <span className={`status ${user.status.toLowerCase()}`}>
                  {user.status}
                </span>
        </td>
      </tr>
    );
  })}
</tbody>
</table>

      </div>

    </div>
     
    </div>
  )
}

export default Users