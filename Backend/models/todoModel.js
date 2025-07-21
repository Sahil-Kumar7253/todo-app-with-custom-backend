const mongoose = require("mongoose");

const TODOListModel = new mongoose.Schema({
    title : String,
    completed :{
        type : Boolean,
        default : false
    },
    userId : {
        type : mongoose.Schema.Types.ObjectId, 
        ref: "User", 
        required: true
     }
},{ timestamps: true });

const TODOList = mongoose.model("TODO",TODOListModel);

module.exports = TODOList;