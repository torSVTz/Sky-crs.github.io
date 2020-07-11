var config = require('./Config/env.config')
const app = require('./Config/index.config')
const port = config.port;
const run_ip = config.run_ip;
const details = config.env;
if (!module.parent) {
    app.listen( 1818, run_ip,() => {
        console.log(`server started on host ${run_ip}:${1818} (${details})`);
    });
    app.listen( 2828, run_ip,() => {
        console.log(`server started on host ${run_ip}: ${2828} (${details})`);
    });
    app.listen( 3838, run_ip,() => {
        console.log(`server started on host ${run_ip}:${3838} (${details})`);
    });
}


module.exports = app;