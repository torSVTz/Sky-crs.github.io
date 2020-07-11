const validate = require('validate.js');
const database = require('./../Config/databases');


class UserController{
    constructor(valid = validate , db = database.MyqlDatabases){
        this._database = new db();
    }

    selectAll(){
        return  this._database.query('select * from tb_customer_type');
    }
    selectOne(){
        return  ["Lomon", "Sihalath"]
    }
}

module.exports = UserController;