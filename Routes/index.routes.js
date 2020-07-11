const express = require('express')
var Userroutes = require('./api/User.routes')
var Temproutes = require('./api/TempLocation.routes')
var Provinceroutes = require('./api/Province.routes')
var Districtroutes = require('./api/District.routes')
var Villageroutes = require('./api/Village.routes')
var Cutomertype = require('./api/Customertype.routes')
var Package = require('./api/Package.routes')
var Customerinfo= require('./api/Customerinfo.routes')
var Register = require('./api/Register.routes')
var advertrise = require('./api/advertrise.routes')
var Apimember = require('./api/apimember.routes')
var DemoLogin = require('./api/demologin.routes')
const router = express.Router()

router.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "www.skycro.com"); // update to match the domain you will make the request from
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
  res.header("Access-Control-Allow-Credentials", true);
  next();
});




router.use('/' , Userroutes)
router.use('/' , Temproutes)
router.use('/' , Provinceroutes)
router.use('/' , Districtroutes)
router.use('/' , Villageroutes)
router.use('/' , Cutomertype)
router.use('/' , Package)
router.use('/' , Register)
router.use('/', Customerinfo)
router.use('/', advertrise)
router.use('/', Apimember)
router.use('/', DemoLogin)

module.exports = router