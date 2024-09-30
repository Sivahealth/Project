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

export const getAppointmentCount = async (req, res) => {
  try {
      const count = await Appointment.countDocuments();
      res.json({ count });
  } catch (error) {
      console.error('Error fetching user count:', error);
      res.status(500).json({ message: 'Error fetching user count' });
  }
};

// controllers/appointmentController.js
export const deleteAppointment = async (req, res) => {
  try {
    const { id } = req.params;

    // Find and delete the appointment
    const appointment = await Appointment.findByIdAndDelete(id);

    if (!appointment) {
      return res.status(404).json({ message: 'Appointment not found' });
    }

    // Find the doctor and remove the booked slot
    const doctor = await Doctor.findById(appointment.doctorId);
    doctor.bookedSlots = doctor.bookedSlots.filter(slot => slot !== appointment.timeSlot);
    await doctor.save();

    res.status(200).json({ message: 'Appointment deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: 'Failed to delete appointment' });
  }
};
