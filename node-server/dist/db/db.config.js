"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var sequelize_1 = require("sequelize");
var dbName = process.env.DB_NAME;
var dbUser = process.env.DB_USER;
var dbHost = process.env.DB_HOST;
var dbDriver = 'mysql';
var dbPassword = process.env.DB_PASSWORD;
var sequelizeConnection = new sequelize_1.Sequelize(dbName, dbUser, dbPassword, {
    host: dbHost,
    dialect: dbDriver
});
exports.default = sequelizeConnection;
//# sourceMappingURL=db.config.js.map