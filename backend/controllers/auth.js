
import User from "../models/user.js";
import { hashPassword } from "../helpers/auth.js";

export const register = async (req, res) => {
  try {
    const { firstName, lastName, email, gender, dob, password } = req.body;

    // Validate required fields
    if (!firstName || !lastName || !email || !gender || !dob || !password) {
      return res.status(400).json({ error: "All fields are required" });
    }

    // Check if user already exists
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ error: "Email is already registered" });
    }

    // Hash password
    const hashedPassword = await hashPassword(password);

    // Create new user instance
    const newUser = new User({
      firstName,
      lastName,
      email,
      gender,
      dateOfBirth: dob,
      password: hashedPassword,
    });

    // Save user to database
    await newUser.save();

    res.json({ message: "Registration successful" });
  } catch (err) {
    console.error("Registration error:", err);
    res.status(500).json({ error: "Registration failed" });
  }
};

export const login = async (req, res) => {
  // Function implementation
};

export const secret = async (req, res) => {
  // Function implementation
};