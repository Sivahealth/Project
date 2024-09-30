// routes/paymentRoutes.js
import express from 'express';
import { createPayment, getPayments, getPaymentCount } from '../controllers/paymentController.js';

const router = express.Router();

router.post('/add', createPayment);  // Add a new payment
router.get('/getpay', getPayments);        // Get all payments
router.get('/count', getPaymentCount); // Get total payment count

export default router;
