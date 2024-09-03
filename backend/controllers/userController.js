
import User from "../models/user.js"; // Assuming User model

export const getUsersCount = async (req, res) => {
    try {
        const count = await User.countDocuments();
        res.json({ count });
    } catch (error) {
        console.error('Error fetching user count:', error);
        res.status(500).json({ message: 'Error fetching user count' });
    }
};

export const getUsers = async (req, res) => {
    try {
        const users = await User.find({});
        res.json(users);
      } catch (error) {
        res.status(500).json({ error: 'Failed to fetch users' });
      }
    };

    export const getUserByUsername = async (req, res) => {
      try {
          const { email } = req.params; // Use 'email' as the parameter
          const user = await User.findOne({ email }); // Query by email
  
          if (user) {
              res.json({
                  firstName: user.firstName,
                  lastName: user.lastName,
                  email: user.email,
                  gender: user.gender,
                  dateOfBirth: user.dateOfBirth,
                  status: user.status,
                  // Include other fields as necessary
              });
          } else {
              res.status(404).json({ message: 'User not found' });
          }
      } catch (error) {
          console.error('Error fetching user details:', error);
          res.status(500).json({ message: 'Error fetching user details' });
      }
  };
  