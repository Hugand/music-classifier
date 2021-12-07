"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getOne = exports.getByPk = exports.getAll = void 0;
const model_1 = __importDefault(require("../model"));
const { Genres } = model_1.default;
const getAll = () => __awaiter(void 0, void 0, void 0, function* () {
    return Genres.findAll();
});
exports.getAll = getAll;
const getByPk = (pk) => __awaiter(void 0, void 0, void 0, function* () {
    const genresEntry = yield Genres.findByPk(pk);
    if (genresEntry === null)
        throw new Error;
    else
        return genresEntry;
});
exports.getByPk = getByPk;
const getOne = (options) => __awaiter(void 0, void 0, void 0, function* () {
    const genresEntry = yield Genres.findOne(options);
    if (genresEntry === null)
        throw new Error;
    else
        return genresEntry;
});
exports.getOne = getOne;
