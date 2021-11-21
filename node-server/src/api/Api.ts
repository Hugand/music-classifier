import { UploadedFile } from "express-fileupload";
import Dataset, { DatasetAttributes } from "../db/model/Dataset.model";
import FormData from 'form-data';
import fetch from 'cross-fetch';

export class Api {
  public static async seed(): Promise<Dataset[]> {
    const datasetEntries: DatasetAttributes[] = await (fetch(`${process.env.MODEL_SERVICE}/audio/seed`, {
      method: 'GET',
    }).then((res: any) => res.json()))

    const dataset: Dataset[] = []

    datasetEntries.forEach((d: DatasetAttributes) => {
      d.seen_by_model = true
      dataset.push(new Dataset(d))
    })

    return dataset
  }

  public static async getAudioClassification(audioFile: UploadedFile): Promise<Dataset> {
    const formData = new FormData()
    formData.append('audioFile', Buffer.from(audioFile.data), audioFile.name)

    const classifiedResultsAttributes: DatasetAttributes = await (fetch(`${process.env.MODEL_SERVICE}/audio/classify`, {
      method: 'POST',
      body: formData as any,
    }).then((res: any) => res.json()))

    return new Dataset(classifiedResultsAttributes)
  }
}