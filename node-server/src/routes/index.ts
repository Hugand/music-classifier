import { Router } from 'express'
import datasetRouter from './dataset.routes'

const router = Router()

router.use('/dataset', datasetRouter)

export default router