import * as datasetDAL from '../db/dal/dataset.dal'
import { DatasetInput, DatasetOuput } from '../db/model/Dataset.model'

export const create = async (payload: DatasetInput): Promise<DatasetOuput> => {
  return await datasetDAL.create(payload)
}

export const getAll = async (): Promise<DatasetOuput[]> => {
  return await datasetDAL.getAll()
}