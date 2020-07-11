const router = require('express').Router();

const TempController = require('./../../Controller/Temp.Controller');
const Temp = new TempController();


router.get('/templocation', (req, res) => res.sendAsyncApi(Temp.selectAll()));

module.exports = router;
