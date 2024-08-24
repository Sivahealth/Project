import express from 'express';
import { createPatient, getPatients } from '../controllers/patientController.js';

const router = express.Router();

router.post('/patients', createPatient);
router.get('/patients', getPatients);

// need to add more routes

export default router;
