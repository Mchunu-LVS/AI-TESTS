MentorLink - Mentorship Platform
A web-based mentorship platform connecting South African students and recent graduates with experienced professionals through structured, paid 1-hour text chat sessions.
What We're Building
MentorLink is a two-sided marketplace where:

Mentees (students/recent grads) can find and book mentorship sessions with industry professionals
Mentors (experienced professionals) can monetize their expertise by offering paid guidance sessions

Core Features

User authentication (separate flows for mentors/mentees)
Profile creation and management
Mentor discovery with filtering and search
Session booking system with calendar integration
Real-time text chat for mentorship sessions
Payment processing for session fees
Session history and management

Technical Architecture
Frontend

Framework: React with TypeScript
Styling: Tailwind CSS
UI Components: Created with v0.dev
State Management: React hooks (useState, useContext)

Backend Requirements (To Be Implemented)
Database Schema
sql-- Users table (both mentors and mentees)
users (
  id, email, password_hash, user_type, 
  first_name, last_name, profile_photo_url, 
  created_at, updated_at
)

-- Mentor-specific profiles
mentor_profiles (
  user_id, company, job_title, years_experience, 
  hourly_rate, bio, skills, availability_schedule
)

-- Mentee-specific profiles
mentee_profiles (
  user_id, university, degree, year_of_study, 
  goals, bio
)

-- Categories/Fields
categories (
  id, name, description, icon_url
)

-- User-Category relationships
user_categories (
  user_id, category_id, is_primary
)

-- Sessions
sessions (
  id, mentor_id, mentee_id, scheduled_at, 
  duration_minutes, status, total_amount, 
  session_goals, notes, created_at
)

-- Messages (for chat)
messages (
  id, session_id, sender_id, content, 
  timestamp, is_read
)

-- Payments
payments (
  id, session_id, amount, currency, 
  payment_method, status, transaction_id, 
  created_at
)
API Endpoints Needed
Authentication

POST /api/auth/register - User registration
POST /api/auth/login - User login
POST /api/auth/logout - User logout
GET /api/auth/me - Get current user

Profile Management

GET /api/profile - Get user profile
PUT /api/profile - Update user profile
POST /api/profile/photo - Upload profile photo

Mentor Discovery

GET /api/mentors - Get mentors with filters
GET /api/mentors/:id - Get specific mentor profile
GET /api/categories - Get all categories

Session Management

POST /api/sessions - Create new session booking
GET /api/sessions - Get user's sessions
GET /api/sessions/:id - Get specific session
PUT /api/sessions/:id - Update session status
DELETE /api/sessions/:id - Cancel session

Chat System

GET /api/sessions/:id/messages - Get session messages
POST /api/sessions/:id/messages - Send message
WebSocket connection for real-time chat

Payment Processing

POST /api/payments/create-intent - Create payment intent
POST /api/payments/confirm - Confirm payment
GET /api/payments/history - Get payment history

Technology Stack Recommendations
Backend Framework

Node.js with Express.js
TypeScript for type safety
JWT for authentication

Database

PostgreSQL (recommended for complex relationships)
Redis for session management and caching

Payment Processing

Stripe (international support)
PayFast (South African payment gateway)
Ozow (South African EFT payments)

Real-time Chat

Socket.io for WebSocket connections
Redis for message queuing

File Storage

AWS S3 or Cloudinary for profile photos
Local storage for development

Email Service

SendGrid or AWS SES for notifications
Email templates for booking confirmations

Environment Variables
env# Database
DATABASE_URL=postgresql://username:password@localhost:5432/mentorlink
REDIS_URL=redis://localhost:6379

# JWT
JWT_SECRET=your-secret-key
JWT_EXPIRES_IN=24h

# Payment Gateways
STRIPE_SECRET_KEY=sk_test_...
PAYFAST_MERCHANT_ID=your-merchant-id
PAYFAST_MERCHANT_KEY=your-merchant-key

# File Storage
AWS_ACCESS_KEY_ID=your-access-key
AWS_SECRET_ACCESS_KEY=your-secret-key
AWS_S3_BUCKET=mentorlink-uploads

# Email
SENDGRID_API_KEY=your-sendgrid-key
FROM_EMAIL=noreply@mentorlink.co.za

# App Settings
NODE_ENV=development
PORT=5000
FRONTEND_URL=http://localhost:3000
Development Setup

Clone the repository
Install dependencies: npm install
Set up database: Run migrations and seed data
Configure environment variables
Start development server: npm run dev

Key Business Logic
Session Booking Flow

Mentee selects mentor and time slot
Payment is processed and held
Session is created with "confirmed" status
Email notifications sent to both parties
Chat room becomes available 5 minutes before session

Payment Processing

Payments are captured upfront when booking
Platform takes 20-30% commission
Mentors are paid after session completion
Refunds available if cancelled >24 hours before

Session Management

Sessions are 1 hour fixed duration
Chat timer automatically ends session
Session transcripts are saved
No-show policies to be implemented

Security Considerations

Password hashing with bcrypt
JWT token expiration and refresh
Input validation and sanitization
Rate limiting on API endpoints
CORS configuration
SQL injection prevention with parameterized queries

Deployment Requirements

Production Database: PostgreSQL with connection pooling
Redis Instance: For session management and caching
File Storage: AWS S3 or similar for profile photos
Email Service: Production email provider
SSL Certificate: HTTPS for secure payments
Environment: Docker containers recommended

Next Steps

Set up the database schema
Implement authentication system
Build core API endpoints
Integrate payment processing
Add real-time chat functionality
Implement email notifications
Add comprehensive error handling
Set up monitoring and logging

Contributing
This is the backend implementation for the MentorLink platform. The frontend UI components are being built with v0.dev based on the design specifications in the UI roadmap.

For backend setup instructions see `backend/README.md`.
