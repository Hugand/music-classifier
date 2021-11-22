import models from './model'
const { Dataset, Genres } = models;
const isDev = process.env.NODE_ENV === 'development'

const dbInit = () => {
  Dataset.sync({ alter: isDev })
  Genres.sync({ alter: isDev })
}

export default dbInit