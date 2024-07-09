// routes/doctorRoutes.js
import express from 'express';
import { addDoctor, getDoctors, updateDoctor, deleteDoctor,getAvailableSlots,getDoctorsByDate } from '../controllers/doctorController.js';

const router = express.Router();

router.post('/doctors', addDoctor);
router.get('/doctors', getDoctors);
router.put('/doctors/:id', updateDoctor);
router.delete('/doctors/:id', deleteDoctor);
router.get('/doctors/:doctorId/slots', getAvailableSlots);
/*router.get('/doctors', getDoctorsByDate);*/
router.post('/by-date', getDoctorsByDate);
export default router;
