const router = require('express').Router();

const ProvinceController = require('./../../Controller/Province.Controller');
const Province = new ProvinceController();


router.get('/province', (req, res) => res.sendAsyncApi(Province.selectAll()));

module.exports = router;
