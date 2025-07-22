const express = require("express");
const body_parser = require("body-parser");
const userRoutes = require("./routes/userRoutes");
const todoRoutes = require("./routes/TODORoutes");

const app = express();
app.use(body_parser.json());
app.use(express.json());
app.use(express.urlencoded({extended:true}));

app.use("/api/users", userRoutes);
app.use("/api/todo", todoRoutes);

module.exports = app;
