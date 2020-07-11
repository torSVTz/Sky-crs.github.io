const router = require('express').Router();

const DistrictController = require('./../../Controller/District.Controller');
const District = new DistrictController();


router.get('/district/:id', (req, res) => res.sendAsyncApi(District.selectAll(req.params.id)));

module.exports = router;
