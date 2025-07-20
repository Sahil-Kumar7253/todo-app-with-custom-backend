const express = require("express");
const body_parser = require("body-parser");
const userRoutes = require("./routes/userRoutes");

const app = express();
app.use(body_parser.json());
app.use(express.json());
app.use(express.urlencoded({extended:true}));

app.use("/users", userRoutes);

module.exports = app;
