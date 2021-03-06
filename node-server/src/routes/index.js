"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const dataset_routes_1 = __importDefault(require("./dataset.routes"));
const router = (0, express_1.Router)();
router.use('/classifier', dataset_routes_1.default);
exports.default = router;
