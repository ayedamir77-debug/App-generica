// Funzione "send-push": manda le notifiche al telefono (anche a schermo spento).
// Genera da sola le chiavi la prima volta: non servono segreti da inserire.
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import webpush from "npm:web-push@3.6.7";

const cors = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};
const json = (o: unknown, status = 200) => new Response(JSON.stringify(o), { status, headers: { ...cors, "Content-Type": "application/json" } });

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: cors });
  try {
    const url = Deno.env.get("SUPABASE_URL")!;
    const sb = createClient(url, Deno.env.get("SUPABASE_ANON_KEY")!, { global: { headers: { Authorization: req.headers.get("Authorization") ?? "" } } });
    const { data: u } = await sb.auth.getUser();
    if (!u?.user) return json({ error: "Accesso non valido" }, 401);
    const { data: p } = await sb.from("profiles").select("company_id, status").eq("id", u.user.id).maybeSingle();
    if (!p || p.status !== "active") return json({ error: "Non autorizzato" }, 403);

    const admin = createClient(url, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!);
    let { data: cfg } = await admin.from("push_config").select("*").eq("id", 1).maybeSingle();
    if (!cfg) {
      const k = webpush.generateVAPIDKeys();
      await admin.from("push_config").upsert({ id: 1, public_key: k.publicKey, private_key: k.privateKey }, { onConflict: "id", ignoreDuplicates: true });
      ({ data: cfg } = await admin.from("push_config").select("*").eq("id", 1).maybeSingle());
    }
    if (!cfg) return json({ error: "Chiavi non disponibili" }, 500);

    const body = await req.json();
    if (body.task === "key") return json({ key: cfg.public_key });

    if (body.task === "send") {
      webpush.setVapidDetails("mailto:noreply@example.com", cfg.public_key, cfg.private_key);
      let q = admin.from("push_subs").select("*").eq("company_id", p.company_id);
      if (Array.isArray(body.to)) q = q.in("user_id", body.to.slice(0, 50));
      if (!body.includeSelf) q = q.neq("user_id", u.user.id);
      const { data: subs } = await q;
      const payload = JSON.stringify({ title: String(body.title || "App Lavori").slice(0, 80), body: String(body.body || "").slice(0, 180), url: String(body.url || "./") });
      let sent = 0;
      await Promise.all((subs || []).map(async (s: { id: string; endpoint: string; p256dh: string; auth: string }) => {
        try {
          await webpush.sendNotification({ endpoint: s.endpoint, keys: { p256dh: s.p256dh, auth: s.auth } }, payload, { TTL: 86400 });
          sent++;
        } catch (e) {
          const code = (e as { statusCode?: number }).statusCode;
          if (code === 404 || code === 410) await admin.from("push_subs").delete().eq("id", s.id);
        }
      }));
      return json({ sent, tried: (subs || []).length });
    }
    return json({ error: "Richiesta non valida" }, 400);
  } catch (e) {
    return json({ error: String((e as Error).message || e) }, 500);
  }
});
