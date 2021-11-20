import {Op} from 'sequelize'
import models from '../model'
import { DatasetInput, DatasetOuput } from '../model/Dataset.model'

const { Dataset } = models

export const create = async (payload: DatasetInput): Promise<DatasetOuput> => {
    const newDatasetEntry = await Dataset.create(payload)
    return newDatasetEntry
}

export const getAll = async (): Promise<DatasetOuput[]> => {
  return Dataset.findAll()
}