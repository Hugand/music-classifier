"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.evaluate = exports.classify = exports.seed = exports.getAll = exports.create = void 0;
const datasetDAL = __importStar(require("../db/dal/dataset.dal"));
const genresDAL = __importStar(require("../db/dal/genres.dal"));
const Api_1 = require("../api/Api");
const create = (payload) => __awaiter(void 0, void 0, void 0, function* () {
    return yield datasetDAL.create(payload);
});
exports.create = create;
const getAll = () => __awaiter(void 0, void 0, void 0, function* () {
    return yield datasetDAL.getAll();
});
exports.getAll = getAll;
const seed = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    console.log("Starting seed");
    const classifiedResults = yield Api_1.Api.seed();
    console.log("Finishing seed");
    classifiedResults.forEach((d) => __awaiter(void 0, void 0, void 0, function* () {
        yield d.save();
    }));
    console.log("Saved");
    return res.status(200).send({
        status: true,
    });
});
exports.seed = seed;
const classify = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    var _a, _b, _c;
    if (!req.files || !((_a = req.files) === null || _a === void 0 ? void 0 : _a.audioFile))
        res.status(400).send();
    try {
        const classificationResults = (yield Api_1.Api.getAudioClassification((_b = req.files) === null || _b === void 0 ? void 0 : _b.audioFile))[0];
        const insertedDatasetEntry = yield classificationResults.save();
        const results = {
            aid: insertedDatasetEntry.id,
            genre: (_c = (yield genresDAL.getByPk(insertedDatasetEntry.label))) === null || _c === void 0 ? void 0 : _c.genre
        };
        return res.status(200).send(results);
    }
    catch (e) {
        return res.status(500).send();
    }
});
exports.classify = classify;
const evaluate = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const genre = yield genresDAL.getOne({ where: { genre: req.body.correctLabel } });
    try {
        yield datasetDAL.update({ label: genre.id, evaluated: true }, { where: { id: req.body.aid } });
    }
    catch (_) {
        return res.status(200).send({ aid: parseInt(req.body.aid), genre: genre.genre, success: false });
    }
    return res.status(200).send({ aid: req.body.aid, genre: genre.genre, success: true });
});
exports.evaluate = evaluate;
