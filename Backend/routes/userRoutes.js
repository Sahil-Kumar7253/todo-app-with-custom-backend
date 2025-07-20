const express = require("express");
const router = express.Router();
const userConrtroller = require("../controllers/userController");

router.get("/", (req, res) => {
  res.send("Hello World!!!");
});

router.post("/register", userConrtroller.handleRegisterUser);


module.exports = router;
