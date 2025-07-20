const jwt = require("jsonwebtoken");
const secret = "ihdfuioy127893hr97823ty0bfuhf893420ifgni0p";

function getUser(token){
    if(!token) return null;

    return jwt.verify(token, secret);
}

function checkforauthentication(req , res , next){
    const authorizationHeaderValue = req.headers["authorization"];

    if (!authorizationHeaderValue || !authorizationHeaderValue.startsWith("Bearer ")) {
        return next();
    }
   
    const token = authorizationHeaderValue.split('Bearer ')[1];
    const user = getUser(token);

    if (user) {
        req.user = user;
    }

    return next();
}

module.exports = {
    checkforauthentication
}