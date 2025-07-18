# MentorLink Backend

This directory contains a minimal Express + Prisma backend for the MentorLink platform described in the project README.

## Setup

1. Copy `.env.example` to `.env` and update the values.
2. Install dependencies:
   ```bash
   npm install
   ```
3. Generate Prisma client and run migrations (requires internet access):
   ```bash
   npx prisma generate
   npx prisma migrate dev --name init
   ```
4. Start the development server:
   ```bash
   npm run dev
   ```

The server will start on `PORT` defined in the `.env` file (default `5000`).

## Provided Endpoints

- `POST /api/auth/register` – create a new user
- `POST /api/auth/login` – user login
- `GET /api/mentors` – list mentors
- `POST /api/sessions` – create a session booking

These endpoints use the database schema defined in `prisma/schema.prisma`.
