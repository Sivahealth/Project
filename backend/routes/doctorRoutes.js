import express from 'express';
import { addDoctor, getDoctors, updateDoctor, deleteDoctor, getAvailableSlots, getDoctorsByDate } from '../controllers/doctorController.js';
import { requireSignin, isAdmin } from '../middlewares/auth.js';

const router = express.Router();

router.post('/doctors', requireSignin, isAdmin, addDoctor);
router.get('/doctors', getDoctors);
router.put('/doctors/:id', requireSignin, isAdmin, updateDoctor);
router.delete('/doctors/:id', requireSignin, isAdmin, deleteDoctor);
router.get('/doctors/:doctorId/slots', getAvailableSlots);
router.post('/doctors/by-date', getDoctorsByDate);

export default router;
