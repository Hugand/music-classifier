import models from './model'
const { Dataset } = models;
const isDev = process.env.NODE_ENV === 'development'

const dbInit = () => {
  Dataset.sync({ alter: isDev })
}

export default dbInit