-- Initial MentorLink database schema
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  user_type TEXT NOT NULL,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  profile_photo_url TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE mentor_profiles (
  user_id INTEGER PRIMARY KEY REFERENCES users(id),
  company TEXT,
  job_title TEXT,
  years_experience INTEGER,
  hourly_rate INTEGER,
  bio TEXT,
  skills TEXT,
  availability_schedule TEXT
);

CREATE TABLE mentee_profiles (
  user_id INTEGER PRIMARY KEY REFERENCES users(id),
  university TEXT,
  degree TEXT,
  year_of_study INTEGER,
  goals TEXT,
  bio TEXT
);

CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL,
  description TEXT,
  icon_url TEXT
);

CREATE TABLE user_categories (
  user_id INTEGER REFERENCES users(id),
  category_id INTEGER REFERENCES categories(id),
  is_primary BOOLEAN DEFAULT false,
  PRIMARY KEY (user_id, category_id)
);

CREATE TABLE sessions (
  id SERIAL PRIMARY KEY,
  mentor_id INTEGER REFERENCES users(id),
  mentee_id INTEGER REFERENCES users(id),
  scheduled_at TIMESTAMPTZ NOT NULL,
  duration_minutes INTEGER NOT NULL,
  status TEXT NOT NULL,
  total_amount INTEGER,
  session_goals TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE messages (
  id SERIAL PRIMARY KEY,
  session_id INTEGER REFERENCES sessions(id),
  sender_id INTEGER REFERENCES users(id),
  content TEXT NOT NULL,
  timestamp TIMESTAMPTZ DEFAULT now(),
  is_read BOOLEAN DEFAULT false
);

CREATE TABLE payments (
  id SERIAL PRIMARY KEY,
  session_id INTEGER REFERENCES sessions(id),
  amount INTEGER NOT NULL,
  currency TEXT NOT NULL,
  payment_method TEXT NOT NULL,
  status TEXT NOT NULL,
  transaction_id TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);
