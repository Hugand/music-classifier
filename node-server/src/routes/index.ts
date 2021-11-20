import { Router } from 'express'
import datasetRouter from './dataset.routes'

const router = Router()

router.use('/classifier', datasetRouter)

export default router