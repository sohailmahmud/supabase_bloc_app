// supabase/functions/send-push/index.ts
import { serve } from "https://deno.land/std@0.131.0/http/server.ts";

// Import Firebase Admin SDK for Deno
import { initializeApp } from "https://esm.sh/firebase-admin@11.11.0/app";
import { getMessaging } from "https://esm.sh/firebase-admin@11.11.0/messaging";

// Firebase Admin config (service account JSON)
const serviceAccount = JSON.parse(Deno.env.get("FIREBASE_SERVICE_ACCOUNT")!);

const app = initializeApp({
  credential: {
    getAccessToken: async () => {
      return {
        access_token: serviceAccount.private_key,
        expires_in: 3600,
      };
    },
  },
});

const messaging = getMessaging(app);

serve(async (req) => {
  try {
    const { userId, title, body } = await req.json();

    // Fetch user’s fcm_token from Supabase
    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const supabaseKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;

    const resp = await fetch(`${supabaseUrl}/rest/v1/profiles?id=eq.${userId}`, {
      headers: {
        "apikey": supabaseKey,
        "Authorization": `Bearer ${supabaseKey}`,
      },
    });
    const data = await resp.json();
    if (!data.length || !data[0].fcm_token) {
      return new Response(JSON.stringify({ error: "No FCM token" }), {
        status: 400,
      });
    }

    const fcmToken = data[0].fcm_token;

    // Send notification
    const message = {
      token: fcmToken,
      notification: {
        title,
        body,
      },
    };

    await messaging.send(message);

    return new Response(JSON.stringify({ success: true }), { status: 200 });
  } catch (err) {
    return new Response(JSON.stringify({ error: err.message }), {
      status: 500,
    });
  }
});
