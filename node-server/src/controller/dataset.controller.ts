import * as datasetDAL from '../db/dal/dataset.dal'
import Dataset, { DatasetInput, DatasetOuput } from '../db/model/Dataset.model'
import {  Request, Response} from 'express'
import { Api } from '../api/Api'
import { UploadedFile } from 'express-fileupload'
import Genres from '../db/model/Genres.model'

export const create = async (payload: DatasetInput): Promise<DatasetOuput> => {
  return await datasetDAL.create(payload)
}

export const getAll = async (): Promise<DatasetOuput[]> => {
  return await datasetDAL.getAll()
}

export const seed = async (req: Request, res: Response) => {
  console.log("Starting seed")
  const classifiedResults: Dataset[] = await Api.seed();
  console.log("Finishing seed")

  classifiedResults.forEach(async (d: Dataset) => {
    await d.save()
  })
  console.log("Saved")

  return res.status(200).send({
    status: true,
  })
}

export const classify = async (req: Request, res: Response) => {
  if (!req.files || !req.files?.audioFile) res.status(400).send()
  
  try {
    const classificationResults: Dataset = (await Api.getAudioClassification(req.files?.audioFile as UploadedFile))[0];
    const insertedDatasetEntry: Dataset = await classificationResults.save()
    const results = {
      aid: insertedDatasetEntry.id,
      genre: (await Genres.findByPk(insertedDatasetEntry.label))?.genre!!
    }
  
    return res.status(200).send(results)
  } catch (e) {
    return res.status(500).send()
  }
}