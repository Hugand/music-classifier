import * as datasetDAL from '../db/dal/dataset.dal'
import Dataset, { DatasetInput, DatasetOuput } from '../db/model/Dataset.model'
import {  Request, Response} from 'express'
import { MockMethods } from './mocks/MockMethods'

export const create = async (payload: DatasetInput): Promise<DatasetOuput> => {
  return await datasetDAL.create(payload)
}

export const getAll = async (): Promise<DatasetOuput[]> => {
  return await datasetDAL.getAll()
}

export const classify = async (req: Request, res: Response) => {
  const classifiedResults: Dataset = MockMethods.getFlaskResults()
  
  await classifiedResults.save()

  const result = await getAll()

  console.log(req.files)

  return res.status(200).send({
    status: true,
    result
  })
}