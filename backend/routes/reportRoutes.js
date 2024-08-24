// routes/reportRoutes.js
import express from 'express';
import { createReport, getReports } from '../controllers/reportController.js';

const router = express.Router();

router.post('/reports', createReport);
router.get('/reports', getReports);

export default router;
