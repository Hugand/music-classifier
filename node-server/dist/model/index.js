"use strict";
var dbConfig = require("../config/db.config.js");
var Sequelize = require("sequelize");
var sequelize = new Sequelize(dbConfig.DB, dbConfig.USER, dbConfig.PASSWORD, {
    host: dbConfig.HOST,
    dialect: dbConfig.dialect,
    operatorsAliases: false,
    pool: {
        max: dbConfig.pool.max,
        min: dbConfig.pool.min,
        acquire: dbConfig.pool.acquire,
        idle: dbConfig.pool.idle
    }
});
var db = {
    Sequelize: null,
    sequelize: null,
    dataset: null
};
db.Sequelize = Sequelize;
db.sequelize = sequelize;
db.dataset = require("./Dataset.model.ts")(sequelize, Sequelize);
module.exports = db;
//# sourceMappingURL=index.js.map