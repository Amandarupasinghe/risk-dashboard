# Prima Risk Dashboard

## Recommended architecture

For this project, the most professional and scalable approach is:

- Frontend: React + Vite deployed on Vercel
- Backend/API: Supabase Edge Functions or a lightweight Node/Express API hosted on Vercel Serverless Functions
- Database: Supabase Postgres
- Authentication: Supabase Auth with role-based access control
- Real-time: Supabase Realtime or server-sent events

## Why this is better than Google Sheets

Google Sheets is easy for quick prototypes, but it is not ideal for a production application because:

- weaker security and access controls
- no reliable transactional consistency for concurrent edits
- limited API performance for multi-user workloads
- harder to enforce role-based permissions cleanly

Supabase gives you:

- a relational database
- secure auth
- row-level security
- real-time subscriptions
- easy Vercel integration

## Suggested project structure

- frontend: React/Vite app
- backend: API routes or Supabase Edge Functions
- database: Postgres tables for risks, mitigations, departments, and users
- auth: Supabase Auth
- env vars: VITE_SUPABASE_URL, VITE_SUPABASE_ANON_KEY, SUPABASE_SERVICE_ROLE_KEY

## Deployment plan

1. Create a Supabase project.
2. Create tables for risks and mitigations.
3. Enable Row Level Security.
4. Configure auth users and roles.
5. Deploy the frontend to Vercel.
6. Add environment variables in Vercel.

## Local development

```bash
npm install
npm run dev
```
