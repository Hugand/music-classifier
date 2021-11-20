import * as datasetDAL from '../db/dal/dataset.dal'
import Dataset, { DatasetInput, DatasetOuput } from '../db/model/Dataset.model'
import {  Request, Response} from 'express'
import { MockMethods } from './mocks/MockMethods'
import { Api } from '../api/Api'
import { UploadedFile } from 'express-fileupload'

export const create = async (payload: DatasetInput): Promise<DatasetOuput> => {
  return await datasetDAL.create(payload)
}

export const getAll = async (): Promise<DatasetOuput[]> => {
  return await datasetDAL.getAll()
}

export const classify = async (req: Request, res: Response) => {
  if (!req.files || !req.files?.audioFile) res.status(400).send()
  
  const classifiedResults: Dataset = await Api.getAudioClassification(req.files?.audioFile as UploadedFile);
  await classifiedResults.save()

  const result = await getAll()
  console.log()

  return res.status(200).send({
    status: true,
    result
  })
}