import { DataTypes, Model, Optional } from 'sequelize'
import sequelizeConnection from '../db.config';

export interface GenresAttributes {
  id: number;
  genre: string;
}

class Genres extends Model<GenresAttributes, GenresAttributes> implements GenresAttributes {
  public id!: number
  public genre!: string;
}

Genres.init({
  id: {
    type: DataTypes.INTEGER.UNSIGNED,
    autoIncrement: true,
    primaryKey: true,
  },
  genre: { type: DataTypes.STRING }
}, {
  timestamps: false,
  sequelize: sequelizeConnection,
  paranoid: true
})

export default Genres