const todoModel = require("../models/todoModel");
const authMiddleware = require('../middleware/authMiddleware');

async function handleAllTODO(req,res) {
    const todo = await todoModel.find({ userId: req.user._id }).sort({ _id: -1 });
    return res.json({todo});
}

async function handleAddTodo(req ,res){
   try {
    const { title } = req.body;

    const todo = await todoModel.create({
      title : title,
      userId: req.user._id,
    });

    return res.json({
      status: true,
      todo,
    });
  } catch (err) {
    console.error('Error creating todo:', err.message);
    return res.status(500).json({ status: false, error: err.message });
  }
}

async function handleUpdateTodo(req,res) {
    const todo = await todoModel.findOneAndUpdate(
    { _id: req.params.id, userId: req.user._id },
     {
        completed : req.body.completed
     },
    );
    return res.json(todo); 
};

async function handleDeleteTodo(req,res){
  await todoModel.findOneAndDelete({ _id: req.params.id, userId: req.user._id});
  return res.json({ msg: 'Deleted' });
}

module.exports = {
    handleAllTODO,
    handleAddTodo,
    handleDeleteTodo,
    handleUpdateTodo
}