const validate = require("validate.js")
const database = require('./../Config/databases')
const bcrypt = require('bcrypt');
const saltRounds = 10;
const config = require('./../Config/env.config')
const jwt = require('jsonwebtoken')
class DemouserController {
    constructor(valid = validate, db = database.MyqlDatabases) {
        this._database = new db();
        this._validate = valid;
        this._validate.validators.presence.message = 'ບໍ່ສາມາດເປັນຄ່າວ່າງໄດ້';
        this.validate_rule = {
            username: {
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


    async SelectUser(token) {
        const items = await this._database.query('call pcd_find_token(?)', [
            token
        ]);
        return items[0];
    }


    async Login(value) {
        const errors = this._validate(this.validate_rule);
        if (errors) throw errors;
        const items = await this._database.query('call pcd_Demologin(?)', [
            value.username,
        ]);
        if (items[0].length === 0) {
            return { success: false, message: "username and password woring please try again" }

        } else {
            if (bcrypt.compareSync(value.password, items[0][0].password) === true) {
                const jwtvalue = jwt.sign({ data: items[0][0] }, config.secretkey, { expiresIn: '5h' });
                const token = await this._database.query('call pcd_updatetoken(?,?)', [
                    jwtvalue,
                    items[0][0].cusid
                ]);
                return { success: true, token: token[0][0].token, cusid: token[0][0].cusid };
            } else {
                return { success: false, message: "username and password woring please try again" }
            }
        }
    }
}













module.exports = DemouserController;