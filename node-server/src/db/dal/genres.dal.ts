import {Identifier, UpdateOptions} from 'sequelize'
import models from '../model'
import { GenresAttributes } from '../model/Genres.model'

const { Genres } = models

export const getAll = async (): Promise<GenresAttributes[]> => {
  return Genres.findAll()
}

export const getByPk = async (pk: Identifier | undefined): Promise<GenresAttributes> => {
  const genresEntry = await Genres.findByPk(pk);

  if (genresEntry === null) throw new Error
  else return genresEntry
}

export const getOne = async (options: Object): Promise<GenresAttributes> => {
  const genresEntry = await Genres.findOne(options);

  if (genresEntry === null) throw new Error
  else return genresEntry
}