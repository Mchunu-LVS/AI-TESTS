import express from 'express';
import cors from 'cors';
import morgan from 'morgan';
import dotenv from 'dotenv';
import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

dotenv.config();

const prisma = new PrismaClient();
const app = express();
app.use(cors());
app.use(express.json());
app.use(morgan('dev'));

const JWT_SECRET = process.env.JWT_SECRET || 'secret';

function generateToken(userId: number) {
  return jwt.sign({ userId }, JWT_SECRET, { expiresIn: '24h' });
}

// Register
app.post('/api/auth/register', async (req, res) => {
  const { email, password, firstName, lastName, userType } = req.body;
  if (!email || !password) return res.status(400).json({ message: 'Missing email or password' });
  const existing = await prisma.user.findUnique({ where: { email } });
  if (existing) return res.status(400).json({ message: 'Email already exists' });
  const passwordHash = await bcrypt.hash(password, 10);
  const user = await prisma.user.create({ data: { email, passwordHash, firstName, lastName, userType } });
  const token = generateToken(user.id);
  res.json({ token, user });
});

// Login
app.post('/api/auth/login', async (req, res) => {
  const { email, password } = req.body;
  const user = await prisma.user.findUnique({ where: { email } });
  if (!user) return res.status(400).json({ message: 'Invalid credentials' });
  const valid = await bcrypt.compare(password, user.passwordHash);
  if (!valid) return res.status(400).json({ message: 'Invalid credentials' });
  const token = generateToken(user.id);
  res.json({ token, user });
});

// Get mentors (basic)
app.get('/api/mentors', async (_req, res) => {
  const mentors = await prisma.user.findMany({ where: { userType: 'mentor' }, include: { mentorProfile: true } });
  res.json(mentors);
});

// Create session
app.post('/api/sessions', async (req, res) => {
  const { mentorId, menteeId, scheduledAt } = req.body;
  const session = await prisma.session.create({
    data: {
      mentorId,
      menteeId,
      scheduledAt: new Date(scheduledAt),
      durationMinutes: 60,
      status: 'confirmed'
    }
  });
  res.json(session);
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
