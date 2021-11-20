import { UploadedFile } from "express-fileupload";
import Dataset, { DatasetAttributes } from "../db/model/Dataset.model";
import FormData from 'form-data';
import fetch from 'cross-fetch';

export class Api {
  public static async getAudioClassification(audioFile: UploadedFile): Promise<Dataset> {
    const formData = new FormData()
    formData.append('audioFile', Buffer.from(audioFile.data), audioFile.name)

    const classifiedResultsAttributes: DatasetAttributes = await (fetch(`${process.env.MODEL_SERVICE}/classifyAudio`, {
      method: 'POST',
      body: formData as any,
    }).then((res: any) => res.json()))

    return new Dataset(classifiedResultsAttributes)
  }
}