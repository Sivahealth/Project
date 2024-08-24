// controllers/reportController.js
import Report from '../models/report.js';

export const createReport = async (req, res) => {
  try {
    const { firstName, lastName, contactNumber, totalCharge, attachedPdf } = req.body;

    const report = new Report({
      firstName,
      lastName,
      contactNumber,
      totalCharge,
      attachedPdf
    });

    await report.save();
    res.status(201).json(report);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

export const getReports = async (req, res) => {
  try {
    const reports = await Report.find();
    res.status(200).json(reports);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};
