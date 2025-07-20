const UserService = require("../services/userService");

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

module.exports = {
    handleRegisterUser
};