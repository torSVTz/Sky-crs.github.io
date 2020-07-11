const validate = require('validate.js');
const database = require('./../Config/databases');


class ProvinceController{
    constructor(valid = validate , db = database.MyqlDatabases){
        this._database = new db();
    }

    async  selectAll(){
           const items = await this._database.query('call pcd_province()');
           return items.length == 0 ? null : items[0]
        }
  
}

module.exports = ProvinceController;