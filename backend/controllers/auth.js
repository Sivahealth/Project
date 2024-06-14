import User from "../models/user.js";
import { hashPassword, comparePassword } from "../helpers/auth.js";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

export const register = async (req, res) => {
  try {
    const { firstName, lastName, email, gender, dateOfBirth, password } =
      req.body;

    if (!firstName.trim()) {
      return res.json({ error: "Name is required" });
    }

    if (!lastName.trim()) {
      return res.json({ error: "Name is required" });
    }

    if (!email) {
      return res.json({ error: "Email is required" });
    }

    if (!gender) {
      return res.json({ error: "Gender is required" });
    }

    if (!dateOfBirth) {
      return res.json({ error: "Date of Birth is required" });
    }

    // if (!phoneno || !/^\d{10}$/.test(phoneno)) {
    //   return res.json({ error: "Phone number should contain 10 numbers" });
    // }

    if (!password || password.length < 6) {
      return res.json({ error: "Password must be at least 6 characters long" });
    }

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.json({ error: "Email is already exist" });
    }

    // const existingPhoneNo = await User.findOne({ phoneno });
    // if (existingPhoneNo) {
    //   return res.json({ error: "Phone Number is already exist" });
    // }

    const hashedPassword = await hashPassword(password);

    const user = await new User({
      firstName,
      lastName,
      email,
      dateOfBirth,
      gender,
      password: hashedPassword,
    }).save();

    const token = jwt.sign({ _id: user._id }, process.env.JWT_SECRET, {
      expiresIn: "7d",
    });

    res.json({
      user: {
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
      },
      token,
    });
  } catch (err) {
    console.log(err);
  }
};

export const login = async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email) {
      return res.json({ error: "Email is required" });
    }

    if (!password || password.length < 6) {
      return res.json({ error: "Password must be at least 6 characters long" });
    }

    const user = await User.findOne({ email });
    if (!user) {
      return res.json({ error: "User not found" });
    }

    const match = await comparePassword(password, user.password);
    if (!match) {
      return res.json({ error: "Wrong password" });
    }

    const token = jwt.sign({ _id: user._id }, process.env.JWT_SECRET, {
      expiresIn: "7d",
    });

    res.json({
      user: {
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
      },
      token,
    });
  } catch (err) {
    console.log(err);
  }
};

export const secret = async (req, res) => {
  res.json({ currentUser: req.user });
};