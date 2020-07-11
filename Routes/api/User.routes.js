const router = require('express').Router();

const UserController = require('./../../Controller/User.Controller');
const User = new UserController();


router.get('/user', (req, res) => res.sendAsyncApi(User.selectAll()));
router.get('/user/:id', (req, res) => res.sendAsyncApi(User.selectOne()));

module.exports = router;
