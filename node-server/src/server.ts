import express, { Application, Request, Response } from 'express'
import http from "http";
const port = process.env.PORT || 3001;
import cors from "cors";
import dotenv from 'dotenv';
dotenv.config();

import routes from './routes'
import dbInit from './db/db.init'
import fileUpload from 'express-fileupload'

dbInit()

const app: Application = express()
const server = http.createServer(app);
  
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
// app.use(express.raw({type: 'application/octet-stream'}))
app.use(fileUpload({ createParentPath: true }));
app.use('/api/v1', routes)

app.get("/", (_req: any, res: any) => {
    console.log("HELLO WORLD THIS WAS CALLED BY THE REST SERVICE")
    res.send({ response: "I am alive" }).status(200);
});

app.use('/api/v1', routes)
server.listen(port, () => console.log(`Listening on port ${port}`));




