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
exports.Api = void 0;
const Dataset_model_1 = __importDefault(require("../db/model/Dataset.model"));
const form_data_1 = __importDefault(require("form-data"));
const cross_fetch_1 = __importDefault(require("cross-fetch"));
class Api {
    static seed() {
        return __awaiter(this, void 0, void 0, function* () {
            const datasetEntries = yield ((0, cross_fetch_1.default)(`${process.env.MODEL_SERVICE}/audio/seed`, {
                method: 'GET',
            }).then((res) => res.json()));
            const dataset = [];
            datasetEntries.forEach((d) => {
                d.seen_by_model = true;
                dataset.push(new Dataset_model_1.default(d));
            });
            return dataset;
        });
    }
    static getAudioClassification(audioFile) {
        return __awaiter(this, void 0, void 0, function* () {
            const formData = new form_data_1.default();
            formData.append('audioFile', Buffer.from(audioFile.data), audioFile.name);
            const classifiedResultsAttributes = yield ((0, cross_fetch_1.default)(`${process.env.MODEL_SERVICE}/audio/classify`, {
                method: 'POST',
                body: formData,
            }).then((res) => res.json()));
            return new Dataset_model_1.default(classifiedResultsAttributes);
        });
    }
}
exports.Api = Api;
