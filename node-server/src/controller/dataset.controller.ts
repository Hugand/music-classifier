import * as datasetDAL from '../db/dal/dataset.dal'
import * as genresDAL from '../db/dal/genres.dal'
import Dataset, { DatasetInput, DatasetOutput } from '../db/model/Dataset.model'
import {  Request, Response} from 'express'
import { Api } from '../api/Api'
import { UploadedFile } from 'express-fileupload'

export const create = async (payload: DatasetInput): Promise<DatasetOutput> => {
  return await datasetDAL.create(payload)
}

export const getAll = async (): Promise<DatasetOutput[]> => {
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
      genre: (await genresDAL.getByPk(insertedDatasetEntry.label))?.genre!!
    }
  
    return res.status(200).send(results)
  } catch (e) {
    return res.status(500).send()
  }
}

export const evaluate = async (req: Request, res: Response) => {
  
  try {
    const genre = await genresDAL.getOne({ where: { genre: req.body.correctLabel }})
    await datasetDAL.update({ label: genre.id }, { where: {id: req.body.aid}})
    
    return res.status(200).send()
  } catch (e) {
    return res.status(500).send()
  }
}

