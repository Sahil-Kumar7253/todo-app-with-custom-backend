const express= require("express");
const router = express.Router();
const todoController = require("../controllers/todoController");
const auth = require("../middleware/authMiddleware").checkforauthentication;

router.get("/", auth,todoController.handleAllTODO);

router.post("/", auth,todoController.handleAddTodo);

router.patch("/:id" , auth,todoController.handleUpdateTodo);

router.delete("/:id" , auth,todoController.handleDeleteTodo);

module.exports = router;