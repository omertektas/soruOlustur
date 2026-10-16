# Mülakat Defteri

Community-driven interview question platform for software and engineering candidates (Turkish UI).
Live: https://www.oftechsolutions.com

**Stack:** Next.js 16 (App Router) · React 19 · TypeScript · Supabase (PostgreSQL + Auth) · Vercel

Step-by-step setup guide (Turkish): **[SETUP.md](./SETUP.md)**

## Features

- Profession → topic → question hierarchy (Frontend, Backend, Full Stack, Game Dev, Network, Embedded, Electrical-Electronics…)
- Sign up / sign in, question submission, submission status tracking
- Admin review panel (approve, reject, unpublish)
- SEO: server rendering + ISR, one URL per question, canonical tags, Open Graph, JSON-LD (QAPage, BreadcrumbList, WebSite), generated `sitemap.xml` and `robots.txt`

## Project structure

```
app/                                  Routes (English folder names)
  page.tsx                            Home
  interview-questions/[profession]/   Profession page
    [topic]/                          Topic page
  questions/[slug]/                   Question page
  search/                             Search
  login/                              Sign in / sign up (+ server actions)
  submit/                             Question submission (+ server action)
  account/                            The user's own questions
  admin/                              Review panel (+ server actions)
  auth/callback, auth/sign-out        Auth endpoints
  sitemap.ts, robots.ts               Search engine files
components/                           Shared UI components
lib/
  data/                               Data access layer (all database queries)
  supabase/                           Supabase clients (public / server / browser / session)
  auth.ts                             Session helpers (requireUser, requireAdmin)
  markdown.tsx                        Safe markdown renderer (no raw HTML)
  route-map.ts                        Public Turkish URL ↔ internal route mapping
  seo.ts                              Metadata and structured data builders
  site.ts                             Site config and URL builders
  slug.ts, validation.ts, types.ts
supabase/
  schema.sql                          Tables + Row Level Security policies
  seed.sql                            Initial professions, topics and questions
proxy.ts                              Session refresh (Next.js proxy)
```

## Public URLs

Folder names are English; visitors and search engines see Turkish, keyword-rich URLs.
`lib/route-map.ts` is the single source of truth, and `next.config.ts` turns it into rewrites
(public → internal) and permanent redirects (internal → public).

| Public URL | Route folder |
| --- | --- |
| `/mulakat-sorulari/frontend-developer` | `app/interview-questions/[profession]` |
| `/mulakat-sorulari/frontend-developer/react` | `app/interview-questions/[profession]/[topic]` |
| `/soru/closure-nedir-bir-ornekle-aciklayin` | `app/questions/[slug]` |
| `/ara`, `/giris`, `/soru-ekle`, `/hesabim`, `/yonetim` | `search`, `login`, `submit`, `account`, `admin` |

## Architecture notes

- **Security lives in the database.** Permissions are enforced with Supabase Row Level Security: users can only insert their own questions as `pending`; only the `admin` role can approve or reject. Server-side checks are a second layer.
- **Fast public pages.** Public pages read through a cookie-less client and are cached with hourly ISR. Approving a question revalidates the affected pages immediately. The header reads the session in the browser so public pages stay static.
- **Layering.** Pages never query the database directly; they call functions in `lib/data`.

## Development

```bash
cp .env.example .env.local   # fill in the values
npm install
npm run dev                  # http://localhost:3000
npm run typecheck
```
