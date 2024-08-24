// controllers/appointmentController.js
import Appointment from '../models/appointment.js';
import Doctor from '../models/doctor.js';

export const createAppointment = async (req, res) => {
  try {
    const { firstName, lastName, dateOfBirth, gender, age, email, address, department, contactNumber, appointmentDate, timeSlot, doctorId } = req.body;

    // Find the doctor
    const doctor = await Doctor.findById(doctorId);

    // Check if the time slot is available
    if (doctor.bookedSlots.includes(timeSlot)) {
      return res.status(400).json({ message: 'Time slot already booked' });
    }

    // Create the appointment
    const appointment = new Appointment({
      firstName,
      lastName,
      dateOfBirth,
      gender,
      age,
      email,
      address,
      department,
      contactNumber,
      appointmentDate,
      timeSlot,
      doctorId,
    });

    await appointment.save();

    // Update the doctor's booked slots
    doctor.bookedSlots.push(timeSlot);
    await doctor.save();

    res.status(201).json(appointment);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

export const getAppointments = async (req, res) => {
  try {
    const appointments = await Appointment.find();
    res.json(appointments);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch appointments' });
  }
};
