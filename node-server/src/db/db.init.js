"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const model_1 = __importDefault(require("./model"));
const { Dataset, Genres } = model_1.default;
const isDev = process.env.NODE_ENV === 'development';
const dbInit = () => {
    Dataset.sync({ alter: isDev });
    Genres.sync({ alter: isDev });
};
exports.default = dbInit;
