import { UploadedFile } from "express-fileupload";
import { MockMethods } from "../controller/mocks/MockMethods";
import Dataset from "../db/model/Dataset.model";

export class Api {
  public static async getAudioClassification(audioFile: UploadedFile): Promise<Dataset> {
    // Make http request
    const classifiedResults: Dataset = MockMethods.getFlaskResults()
    return classifiedResults
  }
}