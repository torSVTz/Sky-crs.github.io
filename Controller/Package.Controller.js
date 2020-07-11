const validate = require("validate.js")
const database = require('../Config/databases')

class PackageController{
    constructor(valid = validate , db = database.MyqlDatabases){
        this._database = new db();
    }
   async selectAll(){
        const items = await  this._database.query('call pcd_package()');
        return items.length == 0 ? null : items[0]
    }

    insertPackage(Data,filename){         
        const items = this._database.query('call pcd_package_insert(?,?,?,?,?,?,?)',[
            Data.package_name_lao,
            Data.package_speed,
            Data.package_price,
            Data.package_amount_months,
            Data.tb_customer_type_id,
            Data.package_name_eng,
            filename,
            Data.package_type
        ]);     
        return items;
    }
}
module.exports = PackageController;