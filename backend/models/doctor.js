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
    bookedSlots: {
        type: [String],
        default: [],
      },
    city:{
      type:String,  
    },
    consultantFee:{
      type:String,
    },
    description:{
      type:String,
    },
    experience:{
      type:String,
    },
    rating:{
      type:String,
    },
    visitingHours:{
      type:String,
    }

  },
  { timestamps: true }
);

export default mongoose.model('Doctor', doctorSchema);
