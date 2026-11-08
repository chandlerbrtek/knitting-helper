# Supabase setup

Knitting Helper uses [Supabase](https://supabase.com) (free tier) for sign-in and cloud backup.
This is a one-time setup, about 10 minutes.

## 1. Create the project

1. Sign up at https://supabase.com and click **New project**.
2. Pick any name (e.g. `knitting-helper`), set a database password (you won't need it in the app), choose a region near you, and create it.

## 2. Create the tables and photo storage

1. In the project, open **SQL Editor** → **New query**.
2. Paste in everything from [`supabase/schema.sql`](supabase/schema.sql) and click **Run**. You should see "Success. No rows returned".

## 3. Put the sign-in code in the email

The app signs you in with a code from your email instead of a link. A code works when the app is
saved to your home screen, but a link would open in Safari instead.

1. Go to **Authentication** → **Emails** → **Templates** → **Magic Link**.
2. Replace the message body with:

   ```html
   <h2>Your Knitting Helper sign-in code</h2>
   <p>Enter this code in the app: <strong>{{ .Token }}</strong></p>
   <p>Or <a href="{{ .ConfirmationURL }}">sign in with this link</a>.</p>
   ```

3. Save. Then do the same for the **Confirm signup** template, which is the email sent the very
   first time you sign in.

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
- **Email limits:** Supabase's built-in email sender only sends a few emails per hour. That's fine for
  signing in, because you stay signed in for a long time.
