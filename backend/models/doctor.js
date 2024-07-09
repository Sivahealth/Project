// models/doctor.js
import mongoose from 'mongoose';

const { Schema } = mongoose;

const doctorSchema = new Schema(
  {
    name: {
      type: String,
      required: true,
      trim: true,
    },
    department: {
      type: String,
      required: true,
      trim: true,
    },
    availableDate: {
      type: Date,
      required: true,
    },
    availableTime: {
      type: String,
      required: true,
    },
    availableSlots: {
        type: Map,
        of: [String],
      },
  },
  { timestamps: true }
);

export default mongoose.model('Doctor', doctorSchema);
