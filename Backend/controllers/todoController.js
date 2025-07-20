const todoModel = require("../models/todoModel");

async function handleAllTODO(req,res) {
    const todo = await todoModel.find({userId : req.user_id});
    return res.json({todo});
}

async function handleAddTodo(req ,res){
    const {title, completed,userId} = req.body;
    const todo = todoModel({
        title : title,
        completed : completed,
        userId : userId
    });
    await todo.save();

    return res.json({
        "status" : true,
        todo : todo
    })
}

async function handleUpdateTodo(req,res) {
    const todo = await todoModel.findOneAndUpdate(
    { _id: req.params.id, userId: req.user._id },
     {
        title : req.body.title,
        completed : req.body.completed
     },
    );
    return res.json(todo); 
};

async function handleDeleteTodo(req,res){
  await todoModel.findOneAndDelete({ _id: req.params.id, userId: req.user._id });
  return res.json({ msg: 'Deleted' });
}

module.exports = {
    handleAllTODO,
    handleAddTodo,
    handleDeleteTodo,
    handleUpdateTodo
}