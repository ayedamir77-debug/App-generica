# Configurazione dei mestieri: fonte unica per database (online) e app (copia di riserva offline)
T = []
def add(id, name, icon, tagline, hero, jobs, job_icons, lib, checks, mats, assets=("Impianti", "Schede impianti dei clienti: accessi, configurazioni, note."), modules=None, sort=0):
    T.append(dict(id=id, name=name, icon=icon, tagline=tagline, hero=hero, jobs=jobs, jobIcons=job_icons,
        libCats=lib, checklists=[dict(name=n, items=i) for n, i in checks], materials=mats,
        assetsLabel=assets[0], assetsHint=assets[1],
        modules=modules or dict(assets=True, library=True, stock=True, vehicles=True, warr=True), sort=sort or len(T) + 1))

add("elettricista", "Elettricista", "⚡", "Impianti elettrici · Sicurezza · Reti",
    ["⚡", "💡", "🔌", "🚪", "📹", "🚨", "📡"],
    ["Impianto elettrico appartamento", "Quadro elettrico", "Cancello automatico", "Videosorveglianza", "Antifurto", "Antenna TV", "Rete e Wi-Fi", "Domotica", "Guasto / intervento"],
    [["cancell|automazion|basculant", "🚪"], ["telecamer|videosorv", "📹"], ["allarm|antifurt", "🚨"], ["antenn|parabol", "📡"], ["rete|internet|wifi", "🌐"], ["domotic", "🏠"], ["quadro", "🔌"], ["luce|lampad|illumin", "💡"]],
    ["Quadri elettrici", "Cancelli e automazioni", "Allarmi", "Telecamere", "Antenne e TV", "Centraline", "Orologi e timer", "Termostati", "Router e rete", "Altro"],
    [("Impianto civile", ["Differenziali e magnetotermici provati", "Messa a terra verificata", "Prese e punti luce provati", "Quadro etichettato", "Dichiarazione di conformità compilata"]),
     ("Cancello automatico", ["Fotocellule provate", "Arresto per ostacolo provato", "Telecomandi memorizzati", "Lampeggiante funzionante", "Sblocco manuale spiegato al cliente"]),
     ("Videosorveglianza", ["Inquadrature verificate", "Registratore configurato", "Accesso da telefono del cliente", "Password consegnate"])],
    ["Cavo 3x1,5", "Cavo 3x2,5", "Corrugato 20", "Scatola 503", "Presa schuko", "Interruttore", "Magnetotermico", "Differenziale", "Centralino", "Morsetti"])

add("idraulico", "Idraulico / Termoidraulico", "🚿", "Impianti idrici · Riscaldamento · Bagni",
    ["🚿", "🔧", "🔥", "🛁", "💧"],
    ["Rifacimento bagno", "Perdita / guasto", "Caldaia", "Impianto di riscaldamento", "Scarico otturato", "Sostituzione sanitari", "Scaldabagno"],
    [["bagno|doccia|sanitar|wc", "🛁"], ["caldai|riscald|termosif|radiator", "🔥"], ["perdit|tubo|scaric|otturat", "💧"]],
    ["Caldaie", "Scaldabagni", "Pompe e circolatori", "Valvole e termostatiche", "Rubinetteria", "Sanitari", "Altro"],
    [("Fine lavori bagno", ["Prova di tenuta eseguita", "Scarichi provati", "Silicone e sigillature fatti", "Rubinetti senza perdite", "Pulizia finale"]),
     ("Manutenzione caldaia", ["Pressione impianto verificata", "Scarico fumi controllato", "Analisi combustione registrata", "Libretto aggiornato"])],
    ["Tubo multistrato 16", "Tubo multistrato 20", "Raccordi a pressare", "Valvola a sfera", "Sifone", "Flessibili", "Teflon", "Silicone"],
    assets=("Impianti", "Schede impianti dei clienti: caldaie, matricole, manutenzioni."))

add("clima", "Climatizzazione / Frigorista", "❄️", "Condizionatori · Pompe di calore · Refrigerazione",
    ["❄️", "🌬️", "🔥", "🔧"],
    ["Installazione condizionatore", "Manutenzione / sanificazione", "Pompa di calore", "Ricarica gas", "Guasto"],
    [["condizion|split|clima", "❄️"], ["pompa di calore", "🔥"], ["sanific|pulizi|manutenz", "🧽"]],
    ["Condizionatori", "Pompe di calore", "Telecomandi e cronotermostati", "Gas refrigeranti", "Altro"],
    [("Installazione split", ["Vuoto eseguito", "Prova di tenuta", "Scarico condensa verificato", "Temperature misurate", "Cliente istruito sull'uso"]),
     ("Manutenzione", ["Filtri puliti", "Batterie sanificate", "Pressioni controllate", "Registro F-gas aggiornato"])],
    ["Tubo rame 1/4", "Tubo rame 3/8", "Staffe", "Canalina", "Scarico condensa", "Gas R32"],
    assets=("Macchine installate", "Schede delle macchine dei clienti: modelli, matricole, manutenzioni."))

add("edile", "Impresa edile / Muratore", "🧱", "Costruzioni · Ristrutturazioni · Manutenzioni",
    ["🧱", "🏗️", "🔨", "🏠"],
    ["Ristrutturazione appartamento", "Rifacimento bagno", "Tramezzi", "Massetto", "Intonaco", "Tetto / copertura", "Facciata"],
    [["tetto|copertur", "🏠"], ["bagno", "🛁"], ["facciat|cappotto", "🏗️"], ["massett|pavimen", "🧱"]],
    ["Attrezzature", "Sicurezza cantiere", "Schede prodotti", "Altro"],
    [("Apertura cantiere", ["Recinzione e cartello", "DPI consegnati", "Allacci provvisori", "Documenti in cantiere"]),
     ("Chiusura cantiere", ["Pulizia finale", "Macerie smaltite", "Foto finali scattate", "Consegna al cliente"])],
    ["Cemento", "Sabbia", "Mattoni forati", "Malta", "Rete elettrosaldata", "Cartongesso"],
    assets=("Cantieri", "Schede dei cantieri: accessi, chiavi, note."))

add("imbianchino", "Imbianchino / Cartongessista", "🎨", "Tinteggiature · Cartongesso · Decorazioni",
    ["🎨", "🖌️", "🧱"],
    ["Tinteggiatura appartamento", "Controsoffitto", "Parete in cartongesso", "Trattamento muffa", "Decorazione"],
    [["controsoff|cartongess", "🧱"], ["muff", "🧽"]],
    ["Pitture e colori", "Attrezzature", "Schede prodotti", "Altro"],
    [("Prima di tinteggiare", ["Mobili coperti", "Pavimenti protetti", "Stuccatura fatta", "Fondo/fissativo dato"])],
    ["Idropittura", "Fissativo", "Stucco", "Nastro carta", "Lastre cartongesso", "Profili"],
    modules=dict(assets=False, library=True, stock=True, vehicles=True, warr=True))

add("falegname", "Falegname / Serramentista", "🪚", "Infissi · Porte · Arredi su misura",
    ["🪚", "🚪", "🪟"],
    ["Sostituzione finestre", "Porte interne", "Zanzariere", "Arredo su misura", "Riparazione"],
    [["finestr|infiss|serrament", "🪟"], ["porta|porte", "🚪"]],
    ["Ferramenta", "Profili", "Vetri", "Schede prodotti", "Altro"],
    [("Posa infissi", ["Misure verificate", "Fissaggio e schiuma", "Silicone esterno", "Regolazione ante", "Pulizia"])],
    ["Schiuma poliuretanica", "Viti", "Silicone", "Coprifili", "Cerniere"],
    modules=dict(assets=False, library=True, stock=True, vehicles=True, warr=True))

add("fabbro", "Fabbro", "🔩", "Carpenteria · Cancelli · Serrature",
    ["🔩", "🚪", "🔐"],
    ["Cancello", "Ringhiera", "Apertura porta", "Cambio serratura", "Inferriate"],
    [["serratur|apertura", "🔐"], ["cancell", "🚪"]],
    ["Serrature", "Profilati", "Schede prodotti", "Altro"],
    [("Consegna lavoro", ["Saldature controllate", "Verniciatura fatta", "Chiavi consegnate"])],
    ["Tubolare", "Piatto ferro", "Elettrodi", "Vernice antiruggine", "Cilindro europeo"],
    modules=dict(assets=False, library=True, stock=True, vehicles=True, warr=True))

add("giardiniere", "Giardiniere", "🌳", "Giardini · Potature · Irrigazione",
    ["🌳", "🌿", "💧", "🌷"],
    ["Taglio erba", "Potatura", "Impianto di irrigazione", "Nuovo giardino", "Manutenzione periodica"],
    [["potatur|albero", "🌳"], ["irrigaz", "💧"], ["erba|prato", "🌿"]],
    ["Macchine", "Irrigazione", "Piante", "Altro"],
    [("Manutenzione giardino", ["Erba tagliata", "Siepi rifilate", "Foglie raccolte", "Irrigazione controllata", "Sfalci smaltiti"])],
    ["Concime", "Terriccio", "Ala gocciolante", "Irrigatori", "Miscela"],
    assets=("Giardini", "Schede dei giardini: accessi, centraline irrigazione, note."))

add("pulizie", "Impresa di pulizie", "🧽", "Pulizie civili e industriali",
    ["🧽", "🧹", "✨"],
    ["Pulizia uffici", "Pulizia condominio", "Pulizia fine cantiere", "Sanificazione", "Vetri"],
    [["vetr", "🪟"], ["sanific", "✨"], ["condomin", "🏘️"]],
    ["Prodotti", "Macchine", "Schede di sicurezza", "Altro"],
    [("Pulizia ufficio", ["Pavimenti", "Bagni", "Cestini svuotati", "Scrivanie spolverate", "Vetri porte"])],
    ["Detergente pavimenti", "Disinfettante", "Sacchi", "Panni microfibra", "Carta"],
    assets=("Sedi dei clienti", "Schede dei luoghi: chiavi, codici allarme, orari."),
    modules=dict(assets=True, library=True, stock=True, vehicles=True, warr=False))

add("informatico", "Tecnico informatico / Reti", "💻", "Computer · Reti · Assistenza",
    ["💻", "🌐", "🖨️", "📶"],
    ["Assistenza PC", "Rete aziendale", "Wi-Fi", "Server / NAS", "Stampanti", "Backup"],
    [["rete|wifi|router", "🌐"], ["stampant", "🖨️"], ["server|nas|backup", "🗄️"]],
    ["Router e switch", "Server e NAS", "Stampanti", "Software", "Altro"],
    [("Nuovo PC", ["Dati trasferiti", "Aggiornamenti installati", "Antivirus attivo", "Backup configurato", "Password consegnate"])],
    ["Cavo di rete", "Plug RJ45", "Switch", "Access point", "SSD"],
    assets=("Impianti", "Schede dei clienti: indirizzi, accessi, configurazioni."))

add("generico", "Altro mestiere", "🛠️", "Lavori · Clienti · Organizzazione",
    ["🛠️", "📋", "📅"],
    ["Sopralluogo", "Intervento", "Manutenzione", "Riparazione"],
    [],
    ["Attrezzature", "Schede prodotti", "Altro"],
    [("Fine lavoro", ["Lavoro controllato", "Area pulita", "Cliente informato"])],
    [],
    assets=("Schede clienti", "Schede con accessi e note per ogni cliente."), sort=99)
