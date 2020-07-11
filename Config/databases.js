const mysql = require('mysql');
const config = require('../Config/env.config')
class MyqlDatabases {
    constructor() {
        this.connection = mysql.createPool({
            host: config.host,  
            port:config.dbport,       
            user:config .usernameDB,
            password: config.passwordDB,
            database: config.databases,
            charset: 'utf8',
            multipleStatements: true
        });         
    }


    // new function query for promise
    query(sql, params = null) {      
        return new Promise((resolve, reject) => {
            this.connection.query(sql, params, function(errors, result)  {             
                if (errors) return reject({ errors });            
                resolve(result);
            });
        });
    }
    close() {
        return new Promise( ( resolve, reject ) => {
            this.connection.end( err => {
                if ( err )
                    return reject( err );
                resolve();
            } );
        } );
    }

}


module.exports = { MyqlDatabases };