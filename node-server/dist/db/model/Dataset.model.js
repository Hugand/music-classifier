"use strict";
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (Object.prototype.hasOwnProperty.call(b, p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        if (typeof b !== "function" && b !== null)
            throw new TypeError("Class extends value " + String(b) + " is not a constructor or null");
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var sequelize_1 = require("sequelize");
var db_config_1 = __importDefault(require("../db.config"));
var Dataset = /** @class */ (function (_super) {
    __extends(Dataset, _super);
    function Dataset() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    return Dataset;
}(sequelize_1.Model));
Dataset.init({
    id: {
        type: sequelize_1.DataTypes.INTEGER.UNSIGNED,
        autoIncrement: true,
        primaryKey: true,
    },
    seen_by_model: {
        type: sequelize_1.DataTypes.BOOLEAN,
        allowNull: false,
    },
    chroma_stft_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    chroma_stft_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    rms_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    rms_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    spectral_centroid_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    spectral_centroid_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    spectral_bandwidth_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    spectral_bandwidth_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    rolloff_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    rolloff_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    zero_crossing_rate_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    zero_crossing_rate_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    harmony_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    harmony_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    perceptr_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    perceptr_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    tempo: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc1_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc1_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc2_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc2_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc3_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc3_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc4_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc4_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc5_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc5_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc6_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc6_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc7_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc7_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc8_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc8_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc9_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc9_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc10_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc10_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc11_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc11_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc12_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc12_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc13_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc13_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc14_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc14_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc15_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc15_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc16_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc16_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc17_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc17_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc18_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc18_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc19_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc19_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc20_mean: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    mfcc20_var: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
    label: {
        type: sequelize_1.DataTypes.DOUBLE,
        allowNull: false,
    },
}, {
    timestamps: true,
    sequelize: db_config_1.default,
    paranoid: true
});
exports.default = Dataset;
//# sourceMappingURL=Dataset.model.js.map