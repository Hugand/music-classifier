import { DataTypes, Model, Optional } from 'sequelize'
import sequelizeConnection from '../db.config';
import Genres from './Genres.model';

export interface DatasetAttributes {
  id: number;
  seen_by_model: boolean;
  chroma_stft_mean: number;
  chroma_stft_var: number;
  rms_mean: number;
  rms_var: number;
  spectral_centroid_mean: number;
  spectral_centroid_var: number;
  spectral_bandwidth_mean: number;
  spectral_bandwidth_var: number;
  rolloff_mean: number;
  rolloff_var: number;
  zero_crossing_rate_mean: number;
  zero_crossing_rate_var: number;
  harmony_mean: number;
  harmony_var: number;
  // perceptr_mean: number;
  // perceptr_var: number;
  tempo: number;
  mfcc1_mean: number;
  mfcc1_var: number;
  mfcc2_mean: number;
  mfcc2_var: number;
  mfcc3_mean: number;
  mfcc3_var: number;
  mfcc4_mean: number;
  mfcc4_var: number;
  mfcc5_mean: number;
  mfcc5_var: number;
  mfcc6_mean: number;
  mfcc6_var: number;
  mfcc7_mean: number;
  mfcc7_var: number;
  mfcc8_mean: number;
  mfcc8_var: number;
  mfcc9_mean: number;
  mfcc9_var: number;
  mfcc10_mean: number;
  mfcc10_var: number;
  mfcc11_mean: number;
  mfcc11_var: number;
  mfcc12_mean: number;
  mfcc12_var: number;
  mfcc13_mean: number;
  mfcc13_var: number;
  mfcc14_mean: number;
  mfcc14_var: number;
  mfcc15_mean: number;
  mfcc15_var: number;
  mfcc16_mean: number;
  mfcc16_var: number;
  mfcc17_mean: number;
  mfcc17_var: number;
  mfcc18_mean: number;
  mfcc18_var: number;
  mfcc19_mean: number;
  mfcc19_var: number;
  mfcc20_mean: number;
  mfcc20_var: number;
  label: number;
}
export interface DatasetInput extends Required<DatasetAttributes> {}
export interface DatasetOuput extends Required<DatasetAttributes> { }

class Dataset extends Model<DatasetAttributes, DatasetInput> implements DatasetAttributes {
  public seen_by_model!: boolean;
  public chroma_stft_mean!: number;
  public chroma_stft_var!: number;
  public rms_mean!: number;
  public rms_var!: number;
  public spectral_centroid_mean!: number;
  public spectral_centroid_var!: number;
  public spectral_bandwidth_mean!: number;
  public spectral_bandwidth_var!: number;
  public rolloff_mean!: number;
  public rolloff_var!: number;
  public zero_crossing_rate_mean!: number;
  public zero_crossing_rate_var!: number;
  public harmony_mean!: number;
  public harmony_var!: number;
  // public perceptr_mean!: number;
  // public perceptr_var!: number;
  public tempo!: number;
  public mfcc1_mean!: number;
  public mfcc1_var!: number;
  public mfcc2_mean!: number;
  public mfcc2_var!: number;
  public mfcc3_mean!: number;
  public mfcc3_var!: number;
  public mfcc4_mean!: number;
  public mfcc4_var!: number;
  public mfcc5_mean!: number;
  public mfcc5_var!: number;
  public mfcc6_mean!: number;
  public mfcc6_var!: number;
  public mfcc7_mean!: number;
  public mfcc7_var!: number;
  public mfcc8_mean!: number;
  public mfcc8_var!: number;
  public mfcc9_mean!: number;
  public mfcc9_var!: number;
  public mfcc10_mean!: number;
  public mfcc10_var!: number;
  public mfcc11_mean!: number;
  public mfcc11_var!: number;
  public mfcc12_mean!: number;
  public mfcc12_var!: number;
  public mfcc13_mean!: number;
  public mfcc13_var!: number;
  public mfcc14_mean!: number;
  public mfcc14_var!: number;
  public mfcc15_mean!: number;
  public mfcc15_var!: number;
  public mfcc16_mean!: number;
  public mfcc16_var!: number;
  public mfcc17_mean!: number;
  public mfcc17_var!: number;
  public mfcc18_mean!: number;
  public mfcc18_var!: number;
  public mfcc19_mean!: number;
  public mfcc19_var!: number;
  public mfcc20_mean!: number;
  public mfcc20_var!: number;
  public label!: number;
  public id!: number
}

Dataset.init({
  id: {
    type: DataTypes.INTEGER.UNSIGNED,
    autoIncrement: true,
    primaryKey: true,
  },
  seen_by_model: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
  },
  chroma_stft_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  chroma_stft_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  rms_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  rms_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  spectral_centroid_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  spectral_centroid_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  spectral_bandwidth_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  spectral_bandwidth_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  rolloff_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  rolloff_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  zero_crossing_rate_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  zero_crossing_rate_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  harmony_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  harmony_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  // perceptr_mean: {
  //   type: DataTypes.DOUBLE,
  //   allowNull: false,
  // },
  // perceptr_var: {
  //   type: DataTypes.DOUBLE,
  //   allowNull: false,
  // },
  tempo: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc1_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc1_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc2_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc2_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc3_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc3_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc4_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc4_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc5_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc5_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc6_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc6_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc7_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc7_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc8_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc8_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc9_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc9_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc10_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc10_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc11_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc11_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc12_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc12_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc13_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc13_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc14_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc14_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc15_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc15_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc16_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc16_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc17_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc17_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc18_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc18_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc19_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc19_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc20_mean: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  mfcc20_var: {
    type: DataTypes.DOUBLE,
    allowNull: false,
  },
  label: {
    type: DataTypes.INTEGER.UNSIGNED,
    allowNull: false,
    references: {
      model: 'Genres',
      key: 'id'
    }
  },
}, {
  timestamps: true,
  sequelize: sequelizeConnection,
  paranoid: true
})

export default Dataset