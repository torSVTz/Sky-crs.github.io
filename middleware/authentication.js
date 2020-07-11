const Demouser = require('./../Controller/Demouser.Comtroller');
 const demologin = new Demouser();


const auth = (req, res, next) =>{
    let token = req.cookies.CRSAPI;
    demologin.SelectUser(token).then(result =>{      
     if (result.length === 0){
        return res.json({
            isAuth: false,         
            message: "You have to login first!",
        })
     }else{
        next();
     }
    })       
}

module.exports = { auth }