require('dotenv').config();

const config = {  
    env: process.env.NODE_ENV,
    port: process.env.PORT,
    host:process.env.HOSTNAEM,
    dbport:process.env.DBPORT,
    usernameDB:process.env.USERNAMEdb,
    passwordDB:process.env.PASSWORD,
    databases:process.env.DATABASES_NAME,
    run_ip:process.env.RUN_IP,
    secretkey : process.env.SECRET_KEY,
    email: process.env.EMAIL,    
    empassword: process.env.EMPASSWORD
};



module.exports = config;
