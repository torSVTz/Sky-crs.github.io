const validate = require("validate.js")
const database = require('./../Config/databases')

class VillageController{
    constructor(valid = validate , db = database.MyqlDatabases){
        this._database = new db();
        this._validate = valid;
        this._validate.validators.presence.message = 'ບໍ່ສາມາດເປັນຄ່າວ່າງໄດ້';
        this.validate_rule = {
            id: {
                presence: {
                    allowEmpty: false
                }
            }
        }
    }
   async selectAll(id){
        const errors = this._validate({ id }, { id: { numericality: true } });
        if (errors) throw { errors };
        const items = await  this._database.query('call pcd_village(?)',[id]);
        return items.length == 0 ? null : items[0]
    }
}
module.exports = VillageController;