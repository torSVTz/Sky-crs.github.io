var express = require('express');
var index = require('./../Routes/index.routes');
var indexview = require('./../Routes/indexview.routes');
var config = require('./env.config')
var logger = require('morgan');
var cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');
const path = require('path')
const RateLimit = require('./RateLimit')
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
require('dotenv').config();

var app = express();

// view engine setup
app.set('views', path.join(__dirname, '../views'));
app.set('view engine', 'ejs');

if (config.env === 'development') {
    app.use(logger('dev'));
}

app.use('/api/upload/image',express.static('upload/image'));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(require('./config'));
app.enable('trust proxy');
app.use(RateLimit.limiter());
app.use(cors());
app.use(morgan('combined'));
app.use(helmet());

app.use('/', indexview);
app.use('/api', index);

// 500 - Any server error
app.use(function (err, req, res, next) {
    return res.status(500).send({ error: err });
});

app.use(function (err, req, res, next) {
    res.status(404);
    // respond with html page
    if (req.accepts('html')) {
        res.render('404', { url: req.url });
        return;
    }
    // respond with json
    if (req.accepts('json')) {
        res.send({ error: 'Not found' });
        return;
    }
    // default to plain-text. send()
    res.type('txt').send('Not found');
})

// 404
app.use(function (req, res, next) {
    return res.status(404).send({ message: 'Route' + req.url + ' Not found.' });
});


module.exports = app;