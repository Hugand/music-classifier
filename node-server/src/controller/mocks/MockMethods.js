"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.MockMethods = void 0;
const Dataset_model_1 = __importDefault(require("../../db/model/Dataset.model"));
class MockMethods {
    static generateRandomDatasetEntry() {
        const audioResults = {
            id: 0,
            seen_by_model: false,
            chroma_stft_mean: (Math.random() * 20) - 10,
            chroma_stft_var: (Math.random() * 20) - 10,
            rms_mean: (Math.random() * 20) - 10,
            rms_var: (Math.random() * 20) - 10,
            spectral_centroid_mean: (Math.random() * 20) - 10,
            spectral_centroid_var: (Math.random() * 20) - 10,
            spectral_bandwidth_mean: (Math.random() * 20) - 10,
            spectral_bandwidth_var: (Math.random() * 20) - 10,
            rolloff_mean: (Math.random() * 20) - 10,
            rolloff_var: (Math.random() * 20) - 10,
            zero_crossing_rate_mean: (Math.random() * 20) - 10,
            zero_crossing_rate_var: (Math.random() * 20) - 10,
            harmony_mean: (Math.random() * 20) - 10,
            harmony_var: (Math.random() * 20) - 10,
            perceptr_mean: (Math.random() * 20) - 10,
            perceptr_var: (Math.random() * 20) - 10,
            tempo: (Math.random() * 20) - 10,
            mfcc1_mean: (Math.random() * 20) - 10,
            mfcc1_var: (Math.random() * 20) - 10,
            mfcc2_mean: (Math.random() * 20) - 10,
            mfcc2_var: (Math.random() * 20) - 10,
            mfcc3_mean: (Math.random() * 20) - 10,
            mfcc3_var: (Math.random() * 20) - 10,
            mfcc4_mean: (Math.random() * 20) - 10,
            mfcc4_var: (Math.random() * 20) - 10,
            mfcc5_mean: (Math.random() * 20) - 10,
            mfcc5_var: (Math.random() * 20) - 10,
            mfcc6_mean: (Math.random() * 20) - 10,
            mfcc6_var: (Math.random() * 20) - 10,
            mfcc7_mean: (Math.random() * 20) - 10,
            mfcc7_var: (Math.random() * 20) - 10,
            mfcc8_mean: (Math.random() * 20) - 10,
            mfcc8_var: (Math.random() * 20) - 10,
            mfcc9_mean: (Math.random() * 20) - 10,
            mfcc9_var: (Math.random() * 20) - 10,
            mfcc10_mean: (Math.random() * 20) - 10,
            mfcc10_var: (Math.random() * 20) - 10,
            mfcc11_mean: (Math.random() * 20) - 10,
            mfcc11_var: (Math.random() * 20) - 10,
            mfcc12_mean: (Math.random() * 20) - 10,
            mfcc12_var: (Math.random() * 20) - 10,
            mfcc13_mean: (Math.random() * 20) - 10,
            mfcc13_var: (Math.random() * 20) - 10,
            mfcc14_mean: (Math.random() * 20) - 10,
            mfcc14_var: (Math.random() * 20) - 10,
            mfcc15_mean: (Math.random() * 20) - 10,
            mfcc15_var: (Math.random() * 20) - 10,
            mfcc16_mean: (Math.random() * 20) - 10,
            mfcc16_var: (Math.random() * 20) - 10,
            mfcc17_mean: (Math.random() * 20) - 10,
            mfcc17_var: (Math.random() * 20) - 10,
            mfcc18_mean: (Math.random() * 20) - 10,
            mfcc18_var: (Math.random() * 20) - 10,
            mfcc19_mean: (Math.random() * 20) - 10,
            mfcc19_var: (Math.random() * 20) - 10,
            mfcc20_mean: (Math.random() * 20) - 10,
            mfcc20_var: (Math.random() * 20) - 10,
            label: Math.round(Math.random() * 9)
        };
        return audioResults;
    }
    static getFlaskResults() {
        const dataset = new Dataset_model_1.default(MockMethods.generateRandomDatasetEntry());
        return dataset;
    }
}
exports.MockMethods = MockMethods;
