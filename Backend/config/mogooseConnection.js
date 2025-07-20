const mongoose = require("mongoose");

const connection = mongoose
   .connect("mongodb://localhost:27017/todo-app")
   .then(() => {
      console.log("Connected to MongoDB");
   });

module.exports = connection;