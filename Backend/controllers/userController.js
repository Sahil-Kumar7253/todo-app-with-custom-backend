const UserService = require("../services/userService");
const UserModel = require("../models/userModel");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const JWT_SECRET="ihdfuioy127893hr97823ty0bfuhf893420ifgni0p"


async function handleRegisterUser(req ,res) {
    try{
      const {name,email,password} = req.body;
      if(!name || !email || !password){ return res.status(400).json({error:"All fields are required"});}
      const user = await UserService.registerUser(name,email,password);
      
      return res.status(201).json({message:"User created successfully",user});
      
    }catch(err){
        return res.status(500).json({ error: "Internal server error"});
    }
}

async function handleLoginUser(req,res){
  const { email, password } = req.body;
  const user = await UserModel.findOne({ email });
   if (!user) return res.status(400).json({ msg: 'Invalid Email' });

  const validPass = await bcrypt.compare(password, user.password);
  if (!validPass) return res.status(400).json({ msg: 'Invalid Password' });

  const token = jwt.sign({ _id : user._id ,email : user.email,},JWT_SECRET);
  return res.json({ token });
}

module.exports = {
    handleRegisterUser,
    handleLoginUser
};