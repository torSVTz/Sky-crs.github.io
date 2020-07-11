const validate = require("validate.js")
const database = require('./../Config/databases')

class AdvertriseController{
    constructor(valid = validate , db = database.MyqlDatabases){
        this._database = new db();
        this._validate = valid;
        this._validate.validators.presence.message = 'ບໍ່ສາມາດເປັນຄ່າວ່າງໄດ້';
        this.validate_rule = {            
            imagepath: {
                presence: {
                    allowEmpty: false
                }
            },
            des: {
                presence: {
                    allowEmpty: false
                }
            },
            tital: {
                presence: {
                    allowEmpty: false
                }
            }
        }
    }
    async selectAll(){    
        const items = await this._database.query('call pcd_advertrise()');
        return items.length == 0 ? null : items[0]
    }

    async InsertData(value,filename){
        const items = await this._database.query('call pcd_advertrise_insert(?,?,?)',
        [
            filename,
            value.tital,
            value.des
        ]);
        return items.length == 0 ? null : items[0]
    }

    async UpdateData(value,filename,id){      
        const items = await this._database.query('call pcd_advertrise_update(?,?,?,?)',
        [
            id,
            filename,
            value.tital,
            value.des           
        ]);
        return items.length == 0 ? null : items[0]
    }
    
}
module.exports = AdvertriseController;