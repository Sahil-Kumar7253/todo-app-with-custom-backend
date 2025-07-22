const mongoose = require("mongoose");
require("dotenv").config();

const dbUri = process.env.MONGO_URI;

const connection = mongoose
   .connect(dbUri)
   .then(() => {
      console.log("Connected to MongoDB");
   });

module.exports = connection;