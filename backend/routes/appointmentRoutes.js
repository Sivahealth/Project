import express from 'express';
import { createAppointment,getAppointments,getAppointmentCount } from '../controllers/appointmentController.js';

const router = express.Router();

router.post('/appointments', createAppointment);
router.get('/', getAppointments);
router.get('/appointments/count',getAppointmentCount)

export default router;