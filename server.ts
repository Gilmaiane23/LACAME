import express from 'express';
require('express-async-errors');
import cors from 'cors';
import cookieParser from 'cookie-parser';
import * as dotenv from 'dotenv';
import {authMiddleware, authRouter} from './helpers/auth'
import errorMiddleware from './errors/errorMiddleware';

dotenv.config({path: './env-local'});
const PORT = process.env.PORT || '3000';

const app = express();
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({extended: false}));
app.use(cookieParser());

app.use('/files', express.static('uploads'));

// Routes
app.get('/', (req, res) => {
    res.status(200).send('HomePage');
})

const userRouter = require('./routes/user');
const projectRouter = require('./routes/project');
const taskRouter = require('./routes/task');
const anexoRouter = require('./routes/anexo');
app.use('/user', userRouter);
app.use('/project', authMiddleware, projectRouter);
app.use('/task', authMiddleware, taskRouter);
app.use('/anexo', authMiddleware, anexoRouter);
app.use('/auth', authMiddleware, authRouter);

app.use(errorMiddleware);

// Listen
app.listen(PORT, ()=>{
    console.log(`Listen in https://localhost:${PORT}`);
})