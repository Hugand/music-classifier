"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const sequelize_1 = require("sequelize");
const db_config_1 = __importDefault(require("../db.config"));
class Genres extends sequelize_1.Model {
}
Genres.init({
    id: {
        type: sequelize_1.DataTypes.INTEGER.UNSIGNED,
        autoIncrement: true,
        primaryKey: true,
    },
    genre: { type: sequelize_1.DataTypes.STRING }
}, {
    timestamps: false,
    sequelize: db_config_1.default,
    paranoid: true
});
exports.default = Genres;
