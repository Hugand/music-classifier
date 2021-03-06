import { Router, Request, Response} from 'express'
import * as datasetController from '../controller/dataset.controller'
const datasetRouter = Router()

datasetRouter.get('/', async (_req: Request, res: Response) => {
  const result = await datasetController.getAll()
  return res.status(200).send(result)
})

datasetRouter.get('/seed', datasetController.seed)

datasetRouter.post('/', datasetController.classify)
datasetRouter.post('/evaluate', datasetController.evaluate)

export default datasetRouter