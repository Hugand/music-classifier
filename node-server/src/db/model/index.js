"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const Dataset_model_1 = __importDefault(require("./Dataset.model"));
const Genres_model_1 = __importDefault(require("./Genres.model"));
exports.default = { 'Dataset': Dataset_model_1.default, 'Genres': Genres_model_1.default };
