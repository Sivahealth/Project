import express from 'express';
import { createAppointment,getAppointments,getAppointmentCount,deleteAppointment } from '../controllers/appointmentController.js';

const router = express.Router();

router.post('/appointments', createAppointment);
router.get('/', getAppointments);
router.get('/appointments/count',getAppointmentCount)
router.delete('/appointments/:id', deleteAppointment);

export default router;