const validate = require("validate.js")
const database = require('../Config/databases')
const jwt = require('jsonwebtoken')
const config = require("./../Config/env.config")
const Helper = require('./../helper/helper')
const Callsendmail = require('../mail/index')
class ApimemberController{
    constructor(valid = validate , db = database.MyqlDatabases){
        this._database = new db();
        this._validate = valid;
        this._validate.validators.presence.message = 'ບໍ່ສາມາດເປັນຄ່າວ່າງໄດ້';
        this.validate_rule = {           
            email: {
                presence: {
                    allowEmpty: false
                }
            },
            password: {
                presence: {
                    allowEmpty: false
                }
            }
        }
    }
    async RegisterApimember(value){
        const errors = this._validate(value ,this.validate_rule);  
        if (errors) throw  errors ;
         const token = "Beer-" + jwt.sign({data:value}, config.secretkey);    
        const items = await this._database.query('call api_member_insert(?,?,?,?)',[
            value.email,
            Helper.EncryptWithAES(value.password),
            'active',
            token
        ]);      
           if (items.affectedRows == 1 ){
            if (Callsendmail.sendEmail(value.email, value.email , token , 'welcomeapi') == true) {              
                return { success: true, items};
            }else{
                return { success: false, message: "please check your email we can not send the code to your email..." }; 
            }       
            }else{
                return items;
            }
    }
}
module.exports = ApimemberController;