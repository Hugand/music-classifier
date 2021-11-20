"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var model_1 = __importDefault(require("./model"));
var Dataset = model_1.default.Dataset;
var isDev = process.env.NODE_ENV === 'development';
var dbInit = function () {
    Dataset.sync({ alter: isDev });
};
exports.default = dbInit;
//# sourceMappingURL=db.init.js.map