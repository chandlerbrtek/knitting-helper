# Supabase setup

Knitting Helper uses [Supabase](https://supabase.com) (free tier) for sign-in and cloud backup.
This is a one-time setup, about 10 minutes.

## 1. Create the project

1. Sign up at https://supabase.com and click **New project**.
2. Pick any name (e.g. `knitting-helper`), set a database password (you won't need it in the app), choose a region near you, and create it.

## 2. Create the tables and photo storage

1. In the project, open **SQL Editor** → **New query**.
2. Paste in everything from [`supabase/schema.sql`](supabase/schema.sql) and click **Run**. You should see "Success. No rows returned".

## 3. Turn off email confirmation

The app signs in with email and password, and it doesn't need to send any email. That avoids
setting up an email service (SMTP).

1. Go to **Authentication** → **Sign In / Providers** → **Email**.
2. Turn **off** "Confirm email" and save.

## 4. Point Supabase at the site

1. Go to **Authentication** → **URL Configuration**.
2. Set **Site URL** to `https://chandlerbrtek.github.io/knitting-helper/`.

## 5. Copy the two values the app needs

Go to **Project Settings** → **API Keys** (or the **Connect** button at the top of the project) and copy:

- **Project URL**: looks like `https://abcdefgh.supabase.co`
- **Publishable key** (or the legacy **anon public** key)

Both are meant to sit in the page's code. Never share the **secret** / **service_role** key.

## Notes

- **Free tier:** 500 MB of data and 1 GB of photos, which is plenty for personal use. A free project pauses
  after about a week with no use at all. Your data is kept, and you can restore it from the dashboard.
- **Accounts:** anyone who finds the site can create an account, but each account only ever sees its own
  projects and photos. To stop new sign-ups after you've made yours, turn off **Allow new users to sign up**
  under Authentication → Sign In / Providers.
- **Forgotten passwords** aren't handled in the app yet. You can reset a password from the Supabase dashboard
  under Authentication → Users.
