const mongoose = require("mongoose");

if (process.env.NODE_ENV !== 'production') {
  require('dotenv').config();
}

const dbUri = process.env.MONGO_URI;

if (!dbUri) {
  console.error("MONGO_URI not found in environment variables. Please set it.");
  process.exit(1);
}

const connectDB = async () => {
  try {
    await mongoose.connect(dbUri);
    console.log("MongoDB connection successful.");
  } catch (error) {
    console.error("MongoDB connection error:", error);
    process.exit(1);
  }
};

module.exports = connectDB;