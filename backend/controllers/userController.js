
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
