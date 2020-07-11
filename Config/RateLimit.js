const RateLimit = require('express-rate-limit');

module.exports = {
    limiter: () => {
        return new RateLimit({
            windowMs: 2 * 60 * 1000, // 2 minutes
            max: 200000, // limit each IP to 100 requests per windowMs
            delayMs: 0 // disable delaying - full speed until the max limit is reached
        });
    }
};