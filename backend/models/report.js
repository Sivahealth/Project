// models/report.js
import mongoose from 'mongoose';

const reportSchema = new mongoose.Schema({
  firstName: { type: String, required: true },
  lastName: { type: String, required: true },
  contactNumber: { type: String, required: true, validate: /^[0-9]{10}$/ }, // 10-digit phone number
  totalCharge: { type: Number, required: true },
  attachedPdf: { type: String, required: true } // Store the file path or URL
}, {
  timestamps: true
});

const Report = mongoose.model('Report', reportSchema);

export default Report;
