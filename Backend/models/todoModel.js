const mongoose = require("mongoose");

const TODOListModel = new mongoose.Schema({
    title : String,
    completed : Boolean,
    userId : {type : mongoose.Types.ObjectId, ref: "User"}
});

const TODOList = mongoose.model("TODO",TODOListModel);

module.exports = TODOList;