const UserModel = require("../models/userModel");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const JWT_SECRET="ihdfuioy127893hr97823ty0bfuhf893420ifgni0p"

class UserService{
   static async registerUser(name,email,password) {
         try{
            const createUser = new UserModel({
               name,
               email,
               password,
            })
            return await createUser.save();
         }catch(err){
              throw err;
         }
   }
}

module.exports = UserService;