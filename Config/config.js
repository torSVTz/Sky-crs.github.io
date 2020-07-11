module.exports = function (req, res, next) {

    // send value with the status
    res.sendApi = function (data, status = 200) {
        res.setHeader('content-type', 'application/Json');
        res.status(status);
        res.json(data);
    };

     /**
     * export value to json with status
     * @param {Promise} promise
     */
    res.sendAsyncApi = function (promise) {
        promise
            .then(item => res.sendApi(item))
            .catch(error => res.sendApi(error, 400));
    };

    next();
};