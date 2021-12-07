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
exports.update = exports.get = exports.getAll = exports.create = void 0;
const model_1 = __importDefault(require("../model"));
const { Dataset } = model_1.default;
const create = (payload) => __awaiter(void 0, void 0, void 0, function* () {
    const newDatasetEntry = yield Dataset.create(payload);
    return newDatasetEntry;
});
exports.create = create;
const getAll = () => __awaiter(void 0, void 0, void 0, function* () {
    return Dataset.findAll();
});
exports.getAll = getAll;
const get = (pk) => __awaiter(void 0, void 0, void 0, function* () {
    const datasetEntry = yield Dataset.findByPk(pk);
    if (datasetEntry === null)
        throw new Error;
    else
        return datasetEntry;
});
exports.get = get;
// { id?: number | Literal | Fn | Col | undefined; seen_by_model?: boolean | Literal | Fn | Col | undefined; chroma_stft_mean?: number | Literal | Fn | Col | undefined; chroma_stft_var?: number | Literal | Fn | Col | undefined; rms_mean?: number | Literal | Fn | Col | undefined; rms_var?: number | Literal | Fn | Col | undefined; spectral_centroid_mean?: number | Literal | Fn | Col | undefined; spectral_centroid_var?: number | Literal | Fn | Col | undefined; spectral_bandwidth_mean?: number | Literal | Fn | Col | undefined; spectral_bandwidth_var?: number | Literal | Fn | Col | undefined; rolloff_mean?: number | Literal | Fn | Col | undefined; rolloff_var?: number | Literal | Fn | Col | undefined; zero_crossing_rate_mean?: number | Literal | Fn | Col | undefined; zero_crossing_rate_var?: number | Literal | Fn | Col | undefined; harmony_mean?: number | Literal | Fn | Col | undefined; harmony_var?: number | Literal | Fn | Col | undefined; tempo?: number | Literal | Fn | Col | undefined; mfcc1_mean?: number | Literal | Fn | Col | undefined; mfcc1_var?: number | Literal | Fn | Col | undefined; mfcc2_mean?: number | Literal | Fn | Col | undefined; mfcc2_var?: number | Literal | Fn | Col | undefined; mfcc3_mean?: number | Literal | Fn | Col | undefined; mfcc3_var?: number | Literal | Fn | Col | undefined; mfcc4_mean?: number | Literal | Fn | Col | undefined; mfcc4_var?: number | Literal | Fn | Col | undefined; mfcc5_mean?: number | Literal | Fn | Col | undefined; mfcc5_var?: number | Literal | Fn | Col | undefined; mfcc6_mean?: number | Literal | Fn | Col | undefined; mfcc6_var?: number | Literal | Fn | Col | undefined; mfcc7_mean?: number | Literal | Fn | Col | undefined; mfcc7_var?: number | Literal | Fn | Col | undefined; mfcc8_mean?: number | Literal | Fn | Col | undefined; mfcc8_var?: number | Literal | Fn | Col | undefined; mfcc9_mean?: number | Literal | Fn | Col | undefined; mfcc9_var?: number | Literal | Fn | Col | undefined; mfcc10_mean?: number | Literal | Fn | Col | undefined; mfcc10_var?: number | Literal | Fn | Col | undefined; mfcc11_mean?: number | Literal | Fn | Col | undefined; mfcc11_var?: number | Literal | Fn | Col | undefined; mfcc12_mean?: number | Literal | Fn | Col | undefined; mfcc12_var?: number | Literal | Fn | Col | undefined; mfcc13_mean?: number | Literal | Fn | Col | undefined; mfcc13_var?: number | Literal | Fn | Col | undefined; mfcc14_mean?: number | Literal | Fn | Col | undefined; mfcc14_var?: number | Literal | Fn | Col | undefined; mfcc15_mean?: number | Literal | Fn | Col | undefined; mfcc15_var?: number | Literal | Fn | Col | undefined; mfcc16_mean?: number | Literal | Fn | Col | undefined; mfcc16_var?: number | Literal | Fn | Col | undefined; mfcc17_mean?: number | Literal | Fn | Col | undefined; mfcc17_var?: number | Literal | Fn | Col | undefined; mfcc18_mean?: number | Literal | Fn | Col | undefined; mfcc18_var?: number | Literal | Fn | Col | undefined; mfcc19_mean?: number | Literal | Fn | Col | undefined; mfcc19_var?: number | Literal | Fn | Col | undefined; mfcc20_mean?: number | Literal | Fn | Col | undefined; mfcc20_var?: number | Literal | Fn | Col | undefined; label?: number | Literal | Fn | Col | undefined }
const update = (values, options) => __awaiter(void 0, void 0, void 0, function* () {
    return yield Dataset.update(values, options);
});
exports.update = update;
