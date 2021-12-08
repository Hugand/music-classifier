import {Identifier, UpdateOptions} from 'sequelize'
import models from '../model'
import { DatasetAttributes, DatasetInput, DatasetOutput } from '../model/Dataset.model'

const { Dataset } = models

export const create = async (payload: DatasetInput): Promise<DatasetOutput> => {
    const newDatasetEntry = await Dataset.create(payload)
    return newDatasetEntry
}

export const getAll = async (): Promise<DatasetOutput[]> => {
  return Dataset.findAll()
}

export const get = async (pk: Identifier | undefined): Promise<DatasetOutput> => {
  const datasetEntry = await Dataset.findByPk(pk);

  if (datasetEntry === null) throw new Error
  else return datasetEntry
}
// { id?: number | Literal | Fn | Col | undefined; seen_by_model?: boolean | Literal | Fn | Col | undefined; chroma_stft_mean?: number | Literal | Fn | Col | undefined; chroma_stft_var?: number | Literal | Fn | Col | undefined; rms_mean?: number | Literal | Fn | Col | undefined; rms_var?: number | Literal | Fn | Col | undefined; spectral_centroid_mean?: number | Literal | Fn | Col | undefined; spectral_centroid_var?: number | Literal | Fn | Col | undefined; spectral_bandwidth_mean?: number | Literal | Fn | Col | undefined; spectral_bandwidth_var?: number | Literal | Fn | Col | undefined; rolloff_mean?: number | Literal | Fn | Col | undefined; rolloff_var?: number | Literal | Fn | Col | undefined; zero_crossing_rate_mean?: number | Literal | Fn | Col | undefined; zero_crossing_rate_var?: number | Literal | Fn | Col | undefined; harmony_mean?: number | Literal | Fn | Col | undefined; harmony_var?: number | Literal | Fn | Col | undefined; tempo?: number | Literal | Fn | Col | undefined; mfcc1_mean?: number | Literal | Fn | Col | undefined; mfcc1_var?: number | Literal | Fn | Col | undefined; mfcc2_mean?: number | Literal | Fn | Col | undefined; mfcc2_var?: number | Literal | Fn | Col | undefined; mfcc3_mean?: number | Literal | Fn | Col | undefined; mfcc3_var?: number | Literal | Fn | Col | undefined; mfcc4_mean?: number | Literal | Fn | Col | undefined; mfcc4_var?: number | Literal | Fn | Col | undefined; mfcc5_mean?: number | Literal | Fn | Col | undefined; mfcc5_var?: number | Literal | Fn | Col | undefined; mfcc6_mean?: number | Literal | Fn | Col | undefined; mfcc6_var?: number | Literal | Fn | Col | undefined; mfcc7_mean?: number | Literal | Fn | Col | undefined; mfcc7_var?: number | Literal | Fn | Col | undefined; mfcc8_mean?: number | Literal | Fn | Col | undefined; mfcc8_var?: number | Literal | Fn | Col | undefined; mfcc9_mean?: number | Literal | Fn | Col | undefined; mfcc9_var?: number | Literal | Fn | Col | undefined; mfcc10_mean?: number | Literal | Fn | Col | undefined; mfcc10_var?: number | Literal | Fn | Col | undefined; mfcc11_mean?: number | Literal | Fn | Col | undefined; mfcc11_var?: number | Literal | Fn | Col | undefined; mfcc12_mean?: number | Literal | Fn | Col | undefined; mfcc12_var?: number | Literal | Fn | Col | undefined; mfcc13_mean?: number | Literal | Fn | Col | undefined; mfcc13_var?: number | Literal | Fn | Col | undefined; mfcc14_mean?: number | Literal | Fn | Col | undefined; mfcc14_var?: number | Literal | Fn | Col | undefined; mfcc15_mean?: number | Literal | Fn | Col | undefined; mfcc15_var?: number | Literal | Fn | Col | undefined; mfcc16_mean?: number | Literal | Fn | Col | undefined; mfcc16_var?: number | Literal | Fn | Col | undefined; mfcc17_mean?: number | Literal | Fn | Col | undefined; mfcc17_var?: number | Literal | Fn | Col | undefined; mfcc18_mean?: number | Literal | Fn | Col | undefined; mfcc18_var?: number | Literal | Fn | Col | undefined; mfcc19_mean?: number | Literal | Fn | Col | undefined; mfcc19_var?: number | Literal | Fn | Col | undefined; mfcc20_mean?: number | Literal | Fn | Col | undefined; mfcc20_var?: number | Literal | Fn | Col | undefined; label?: number | Literal | Fn | Col | undefined }
export const update = async (values: Object, options: UpdateOptions<DatasetAttributes>): Promise<[number, DatasetOutput[]]> => {
  return await Dataset.update(values, options);
}