// models/payment.js
import mongoose from 'mongoose';

const paymentSchema = new mongoose.Schema({
  employeeName: { type: String, required: true },
  accountNumber: { type: String, required: true, validate: /^[0-9]{10,12}$/ }, // Assuming 10-12 digit account number
  selectedStatus: { type: String, required: true, enum: ['Doctor', 'Employee'] },
  manHours: { type: String, required: true },
  overTime: { type: String, required: true },
  totalAmount: { type: Number, required: true }
}, {
  timestamps: true
});

const Payment = mongoose.model('Payment', paymentSchema);

export default Payment;
