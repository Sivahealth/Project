import express from 'express';
import { createAppointment, getAppointments, updateAppointment, deleteAppointment } from '../controllers/appointmentController.js';
import { requireSignin, isAdmin } from '../middlewares/auth.js';

const router = express.Router();

router.post('/appointments', requireSignin, createAppointment);
router.get('/appointments', getAppointments);
router.put('/appointments/:id', requireSignin, isAdmin, updateAppointment);
router.delete('/appointments/:id', requireSignin, isAdmin, deleteAppointment);

export default router;
