#!/usr/bin/env bash
set -euo pipefail
# Simple static HTML generator used during early scaffolding.
# Keep it aligned with the current site styles and avoid external font requests.
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

header() {
  local title="$1"; local desc="$2"; local canon="$3"; local keywords="$4"
  cat <<HTML
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>${title}</title>
  <meta name="description" content="${desc}">
  <meta name="keywords" content="${keywords}">
  <meta name="robots" content="index,follow,max-image-preview:large,max-snippet:-1,max-video-preview:-1">
  <link rel="canonical" href="${canon}">
  <link rel="alternate" hreflang="en" href="https://pilatesmallorca.com/en/">
  <link rel="alternate" hreflang="de" href="https://pilatesmallorca.com/de/">
  <link rel="alternate" hreflang="es" href="https://pilatesmallorca.com/es/">
  <link rel="alternate" hreflang="sv" href="https://pilatesmallorca.com/sv/">
  <link rel="alternate" hreflang="x-default" href="https://pilatesmallorca.com/en/">
  <meta property="og:type" content="website">
  <meta property="og:title" content="${title}">
  <meta property="og:description" content="${desc}">
  <meta property="og:url" content="${canon}">
  <meta property="og:site_name" content="Mallorca Pilates">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="${title}">
  <meta name="twitter:description" content="${desc}">
  <link rel="stylesheet" href="/assets/css/styles.css">
  <script defer src="/assets/js/main.js"></script>
</head>
<body>
<header class="site-header">
  <div class="container header-inner">
    <a class="logo" href="/"><span>Mallorca</span> Pilates</a>
    <button class="nav-toggle" data-nav-toggle aria-label="Open menu">Menu</button>
    <nav class="site-nav" data-nav>
      <a href="/retreats/">Retreats</a>
      <a href="/teachers/">Teachers</a>
      <a href="/studios/">Studios</a>
      <a href="/blog/">Blog</a>
      <a href="/faq/">FAQ</a>
      <a href="/signup/">Get Matched</a>
    </nav>
  </div>
</header>
<main class="container">
HTML
}

footer() {
  cat <<'HTML'
</main>
<footer class="site-footer">
  <div class="container footer-grid">
    <div><strong>Mallorca Pilates</strong><p class="meta">Directory + education for Reformer Pilates in Mallorca.</p></div>
    <div><a href="/retreats/">Retreats</a><br><a href="/teachers/">Teachers</a><br><a href="/studios/">Studios</a></div>
    <div><a href="/blog/">Blog</a><br><a href="/faq/">FAQ</a><br><a href="/brand/">Brand</a></div>
    <div><a href="/privacy/">Privacy</a><br><a href="/terms/">Terms</a><br><a href="/contact/">Contact</a></div>
  </div>
</footer>
<div class="sticky-mobile-cta"><a class="button primary" href="/signup/">Get Matched</a></div>
</body>
</html>
HTML
}

write_page() {
  local path="$1"; local title="$2"; local desc="$3"; local canon="$4"; local keywords="$5"; local h1="$6"; local lead="$7"; local body="$8"
  mkdir -p "$(dirname "$path")"
  {
    header "$title" "$desc" "$canon" "$keywords"
    cat <<HTML
<section class="hero article">
  <p class="breadcrumb"><a href="/">Home</a></p>
  <h1>${h1}</h1>
  <p>${lead}</p>
</section>
<section class="section article">
${body}
  <div class="card related-links">
    <h3>Related next steps</h3>
    <p class="meta"><a href="/studios/">Browse studios</a> · <a href="/teachers/reformer/">Find reformer teachers</a> · <a href="/blog/">Read guides</a> · <a href="/signup/">Get matched</a></p>
  </div>
</section>
HTML
    footer
  } > "$path"
}

write_page "studios/index.html" "Reformer Pilates Mallorca Studio Directory | Mallorca Reformer" "Browse Reformer Pilates studios in Mallorca by area, language, level, and schedule." "https://pilatesmallorca.com/studios/" "reformer pilates mallorca,pilates classes mallorca,pilates studio mallorca" "Reformer Pilates studios in Mallorca" "Use this directory to discover studios and compare formats before booking." "
<div class='notice'><strong>How rankings are built:</strong> profile completeness, schedule availability, verified reformer equipment, and learner reviews.</div>
<div class='card'>
  <h3>Find your fit fast</h3>
  <div class='grid cols-2'>
    <label>Area
      <select data-studio-filter='area'>
        <option value='all'>All areas</option>
        <option value='palma'>Palma</option>
        <option value='calvia'>Calvia</option>
        <option value='alcudia'>Alcudia</option>
        <option value='soller'>Soller</option>
        <option value='andratx'>Andratx</option>
      </select>
    </label>
    <label>Type
      <select data-studio-filter='type'>
        <option value='all'>All types</option>
        <option value='beginner'>Beginner friendly</option>
        <option value='private'>Private available</option>
        <option value='athletic'>Athletic focus</option>
      </select>
    </label>
  </div>
</div>
<div class='grid cols-2'>
  <article class='card studio-card' data-area='palma' data-type='beginner private'><h3><a href='/studios/palma/'>Palma</a></h3><p class='meta'>Urban studios, highest timetable flexibility.</p></article>
  <article class='card studio-card' data-area='calvia' data-type='private athletic'><h3><a href='/studios/calvia/'>Calvia</a></h3><p class='meta'>Boutique classes and private coaching.</p></article>
  <article class='card studio-card' data-area='alcudia' data-type='beginner'><h3><a href='/studios/alcudia/'>Alcudia</a></h3><p class='meta'>Coastal and family-friendly options.</p></article>
  <article class='card studio-card' data-area='soller' data-type='beginner'><h3><a href='/studios/soller/'>Soller</a></h3><p class='meta'>Technique-focused and rehab-conscious studios.</p></article>
  <article class='card studio-card' data-area='andratx' data-type='private'><h3><a href='/studios/andratx/'>Andratx</a></h3><p class='meta'>Private premium classes and mixed-level groups.</p></article>
  <article class='card studio-card' data-area='palma' data-type='athletic'><h3><a href='/studios/map/'>Map View</a></h3><p class='meta'>Plan by location and travel convenience.</p></article>
</div>
"

write_page "studios/palma/index.html" "Pilates Palma de Mallorca: Reformer Studios | Mallorca Reformer" "Compare Reformer Pilates studios in Palma de Mallorca with class type, price range, and languages." "https://pilatesmallorca.com/studios/palma/" "pilates palma de mallorca,reformer pilates palma,pilates palma" "Best Reformer Pilates studios in Palma" "Palma is the strongest location for Reformer Pilates in Mallorca with options across all levels." "
<div class='grid cols-2'>
  <article class='card'><h3>Centro Reformer Palma</h3><p class='meta'>From EUR 22/class · ES/EN · Beginner to advanced</p><div class='badges'><span class='badge'>6 Reformers</span><span class='badge'>Small Groups</span></div></article>
  <article class='card'><h3>Passeig Pilates Lab</h3><p class='meta'>From EUR 28/class · ES/EN/DE · Core + posture focus</p><div class='badges'><span class='badge'>Private Sessions</span><span class='badge'>Physio Support</span></div></article>
  <article class='card'><h3>Santa Catalina Reformer House</h3><p class='meta'>From EUR 24/class · EN/DE · Dynamic athletic blocks</p><div class='badges'><span class='badge'>Athletic</span><span class='badge'>Evening Classes</span></div></article>
  <article class='card'><h3>Palma Old Town Studio</h3><p class='meta'>From EUR 20/class · ES/EN · Slow controlled method</p><div class='badges'><span class='badge'>Beginner Friendly</span><span class='badge'>Morning Slots</span></div></article>
</div>
<p><a class='button primary' href='/signup/'>Get a personalized Palma shortlist</a></p>
"

write_page "studios/calvia/index.html" "Reformer Pilates Calvia Studios | Mallorca Reformer" "Discover Reformer Pilates studios in Calvia with verified equipment and multilingual teachers." "https://pilatesmallorca.com/studios/calvia/" "reformer pilates mallorca,pilates calvia,pilates classes mallorca" "Reformer Pilates in Calvia" "Calvia combines boutique training with premium hotel-area convenience." "
<div class='grid cols-2'>
  <article class='card'><h3>Calvia Core Studio</h3><p class='meta'>From EUR 27/class · ES/EN · Strength + alignment</p></article>
  <article class='card'><h3>Magaluf Reformer Collective</h3><p class='meta'>From EUR 19/class · EN/DE · Group reformer foundations</p></article>
  <article class='card'><h3>Palmanova Body Lab</h3><p class='meta'>From EUR 25/class · ES/EN · Posture reset courses</p></article>
  <article class='card'><h3>Santa Ponsa Reformer Works</h3><p class='meta'>From EUR 30/class · EN · Private and duo sessions</p></article>
</div>
"

write_page "studios/alcudia/index.html" "Reformer Pilates Alcudia Studios | Mallorca Reformer" "Find Reformer Pilates classes in Alcudia for beginners and experienced practitioners." "https://pilatesmallorca.com/studios/alcudia/" "pilates classes mallorca,reformer pilates mallorca,pilates alcudia" "Reformer Pilates in Alcudia" "Alcudia offers flexible options for residents and visitors who want structured movement sessions." "
<div class='grid cols-2'>
  <article class='card'><h3>Port d'Alcudia Reformer Club</h3><p class='meta'>From EUR 21/class · ES/EN · Intro tracks and progression plans</p></article>
  <article class='card'><h3>Nord Pilates Studio</h3><p class='meta'>From EUR 24/class · ES/DE · Focus on spinal mobility</p></article>
</div>
"

write_page "studios/soller/index.html" "Reformer Pilates Soller Studios | Mallorca Reformer" "Browse Soller Reformer Pilates studios with schedule and level filters." "https://pilatesmallorca.com/studios/soller/" "reformer pilates mallorca,pilates soller,pilates classes mallorca" "Reformer Pilates in Soller" "Soller studios are ideal for technique quality, control, and low-impact strength progressions." "
<div class='grid cols-2'>
  <article class='card'><h3>Soller Precision Pilates</h3><p class='meta'>From EUR 29/class · EN/DE · Control and tempo training</p></article>
  <article class='card'><h3>Tramuntana Reformer Space</h3><p class='meta'>From EUR 26/class · ES/EN · Reformer and tower combos</p></article>
</div>
"

write_page "studios/andratx/index.html" "Reformer Pilates Andratx Studios | Mallorca Reformer" "Compare Reformer Pilates in Andratx with private and premium small group options." "https://pilatesmallorca.com/studios/andratx/" "reformer pilates mallorca,pilates andratx,pilates classes mallorca" "Reformer Pilates in Andratx" "Andratx focuses on premium teaching ratios and personalized movement coaching." "
<div class='grid cols-2'>
  <article class='card'><h3>Andratx Reformer Atelier</h3><p class='meta'>From EUR 34/class · EN/DE · 1:1 and duo coaching</p></article>
  <article class='card'><h3>Puerto Andratx Movement Studio</h3><p class='meta'>From EUR 31/class · ES/EN · Strength + flexibility programming</p></article>
</div>
"

write_page "studios/map/index.html" "Mallorca Reformer Studio Map | Mallorca Reformer" "Plan Reformer Pilates classes in Mallorca by location and commute time." "https://pilatesmallorca.com/studios/map/" "pilates mallorca,reformer pilates mallorca,pilates studios map mallorca" "Map view: Reformer Pilates Mallorca" "Use area-based planning before selecting your studio shortlist." "
<div class='card'>
  <p class='meta'>Interactive map placeholder for production integration (Mapbox/Google Maps).</p>
  <ul class='list'>
    <li>Palma: urban and high-frequency schedules</li>
    <li>Calvia: premium studio mix</li>
    <li>Alcudia/Soller/Andratx: destination and lifestyle options</li>
  </ul>
</div>
"

write_page "teachers/index.html" "Pilates Teachers in Mallorca | Mallorca Reformer" "Find certified Pilates teachers in Mallorca by specialty, language, and lesson style." "https://pilatesmallorca.com/teachers/" "pilates mallorca,pilates teachers mallorca,reformer coach mallorca" "Pilates teachers in Mallorca" "Get matched with teachers for strength, recovery, mobility, or beginner onboarding." "
<div class='grid cols-2'>
  <article class='card'><h3>Ana M.</h3><p class='meta'>ES/EN · Posture and low back care</p></article>
  <article class='card'><h3>Leonie R.</h3><p class='meta'>EN/DE · Athletic performance and core power</p></article>
  <article class='card'><h3>Carlos V.</h3><p class='meta'>ES/EN · Beginner progression plans</p></article>
  <article class='card'><h3>Julia S.</h3><p class='meta'>DE/EN · Mobility and flexibility blocks</p></article>
</div>
<p><a class='button primary' href='/signup/'>Match me with a teacher</a></p>
"

write_page "teachers/reformer/index.html" "Reformer Pilates Teachers Mallorca | Mallorca Reformer" "Specialist Reformer Pilates teachers in Mallorca for private and group classes." "https://pilatesmallorca.com/teachers/reformer/" "reformer pilates mallorca,reformer teacher mallorca,pilates instructors mallorca" "Specialist Reformer teachers" "These teachers focus on equipment-based Pilates programming and safe progression." "
<ul class='list'>
  <li>Rehab-aware sequences</li>
  <li>Sport-specific strength programs</li>
  <li>Beginner foundations with cueing precision</li>
</ul>
"

write_page "beginners/reformer-pilates-mallorca/index.html" "Reformer Pilates for Beginners in Mallorca | Mallorca Reformer" "Beginner guide to start Reformer Pilates in Mallorca safely and consistently." "https://pilatesmallorca.com/beginners/reformer-pilates-mallorca/" "reformer pilates mallorca,reformer pilates beginner,pilates classes mallorca" "Beginner guide: Reformer Pilates Mallorca" "If you are new to Pilates, start with stability, breath, and controlled range before higher resistance." "
<ol class='list'>
  <li>Take 2-3 intro sessions focused on breathing and alignment.</li>
  <li>Prioritize cue quality over class intensity.</li>
  <li>Progress resistance gradually and track control metrics.</li>
</ol>
<p>Next step: <a href='/signup/'>request a beginner-safe studio match</a>.</p>
"

write_page "compare/reformer-vs-yoga-mat/index.html" "Reformer Pilates vs Yoga Mat: Evidence-Based Comparison" "Compare Reformer Pilates and yoga mat practice with practical outcomes and trusted sources." "https://pilatesmallorca.com/compare/reformer-vs-yoga-mat/" "reformer vs yoga mat,reformer pilates benefits,pilates mallorca" "Reformer Pilates vs classical yoga on the mat" "Both methods can improve physical function; choose based on goals, coaching access, and loading preferences." "
<div class='grid cols-2'>
  <article class='card'><h3>Reformer Pilates</h3><ul class='list'><li>Adjustable resistance for progressive overload</li><li>Equipment feedback improves body awareness</li><li>Useful for controlled strength and posture work</li></ul></article>
  <article class='card'><h3>Classical Yoga on mat</h3><ul class='list'><li>Accessible and low equipment barrier</li><li>Emphasis on flexibility and breath integration</li><li>Strong option for stress regulation and mobility</li></ul></article>
</div>
<div class='notice'>Sources: <a href='https://www.who.int/news-room/fact-sheets/detail/physical-activity' target='_blank' rel='noopener'>WHO physical activity guidance</a>, <a href='https://pubmed.ncbi.nlm.nih.gov/24346291/' target='_blank' rel='noopener'>Pilates and low back pain meta-analysis</a>, <a href='https://pubmed.ncbi.nlm.nih.gov/32870936/' target='_blank' rel='noopener'>Yoga and low back pain evidence</a>.</div>
"

write_page "pricing/index.html" "Mallorca Reformer Pricing & Plans" "See lead plans and partner options for connecting with Reformer Pilates studios in Mallorca." "https://pilatesmallorca.com/pricing/" "pilates classes mallorca,reformer pilates mallorca,pilates pricing mallorca" "Pricing and partner plans" "For users, the matching service is free. Studios can request partner visibility plans." "
<div class='grid cols-2'>
  <article class='card'><h3>User Matching</h3><p class='meta'>EUR 0 · Personalized studio and teacher shortlist</p></article>
  <article class='card'><h3>Studio Partner</h3><p class='meta'>From EUR 79/month · Featured listings and lead routing</p></article>
</div>
"

write_page "about/index.html" "About Mallorca Reformer" "Learn how Mallorca Reformer helps people find the best Reformer Pilates studio and teacher." "https://pilatesmallorca.com/about/" "pilates mallorca,reformer pilates mallorca,about mallorca reformer" "About Mallorca Reformer" "We are a local-first directory and educational resource focused on evidence-led movement guidance." "
<p>Mission: connect users with high-fit Reformer Pilates studios in Mallorca and publish tutorials that reduce beginner friction.</p>
<p>Editorial standards: cite authoritative sources for all health-related claims.</p>
"

write_page "contact/index.html" "Contact Mallorca Reformer" "Contact the Mallorca Reformer team for support, partnerships, and listing updates." "https://pilatesmallorca.com/contact/" "pilates mallorca contact,reformer pilates mallorca" "Contact us" "Use this form for support and studio listing requests." "
<form class='form'>
  <label>Name <input type='text' name='name' required></label>
  <label>Email <input type='email' name='email' required></label>
  <label>Message <textarea name='message' required></textarea></label>
  <button class='button primary' type='submit'>Send</button>
</form>
"

write_page "signup/index.html" "Sign Up: Get Matched with a Reformer Pilates Studio" "Sign up and get matched with Reformer Pilates studios and teachers in Mallorca." "https://pilatesmallorca.com/signup/" "reformer pilates mallorca,pilates classes mallorca,pilates palma" "Sign up for studio and teacher matching" "Complete this short intake to receive options tailored to your goals, budget, and location." "
<form class='form'>
  <label>Full Name <input type='text' required></label>
  <label>Email <input type='email' required></label>
  <label>Preferred Area
    <select>
      <option>Palma</option><option>Calvia</option><option>Alcudia</option><option>Soller</option><option>Andratx</option>
    </select>
  </label>
  <label>Goal
    <select>
      <option>Beginner onboarding</option><option>Strength and posture</option><option>Mobility and flexibility</option><option>Back-care support</option>
    </select>
  </label>
  <label>Language
    <select>
      <option>Spanish</option><option>English</option><option>German</option>
    </select>
  </label>
  <button class='button primary' type='submit'>Get My Matches</button>
</form>
"

write_page "blog/index.html" "Pilates & Reformer Blog Mallorca | Tutorials and Guides" "Read SEO-optimized Pilates tutorials, beginner guides, and evidence-based comparisons." "https://pilatesmallorca.com/blog/" "pilates blog mallorca,reformer pilates benefits,reformer vs yoga" "Pilates tutorials and Reformer guides" "Explore practical lessons, plans, and comparisons designed for Mallorca learners." "
<div class='grid cols-2'>
  <article class='card'><h3><a href='/blog/reformer-pilates-beginners-mallorca/'>Reformer Pilates for beginners in Mallorca</a></h3></article>
  <article class='card'><h3><a href='/blog/reformer-vs-yoga-mat-goals/'>Reformer vs yoga mat: which fits your goals?</a></h3></article>
  <article class='card'><h3><a href='/blog/pilates-breathing-basics/'>Best Pilates breathing basics</a></h3></article>
  <article class='card'><h3><a href='/blog/common-reformer-mistakes/'>10 common Reformer mistakes</a></h3></article>
  <article class='card'><h3><a href='/blog/pilates-for-back-pain-evidence/'>Pilates for back pain: what evidence says</a></h3></article>
  <article class='card'><h3><a href='/blog/how-often-reformer-pilates/'>How often should you do Reformer Pilates?</a></h3></article>
  <article class='card'><h3><a href='/blog/private-vs-group-reformer/'>Private vs group Reformer classes</a></h3></article>
  <article class='card'><h3><a href='/blog/choose-pilates-teacher-mallorca/'>Choosing the right Pilates teacher</a></h3></article>
  <article class='card'><h3><a href='/blog/reformer-4-week-roadmap/'>Beginner 4-week Reformer roadmap</a></h3></article>
  <article class='card'><h3><a href='/blog/choose-studio-palma/'>How to pick a Pilates studio in Palma</a></h3></article>
</div>
<p><a class='button secondary' href='/signup/'>Need a personal recommendation? Sign up</a></p>
"

write_page "brand/index.html" "Brand Guidelines | Mallorca Reformer" "Visual and UX standards for Mallorca Reformer: color palette, typography, and mobile behavior." "https://pilatesmallorca.com/brand/" "brand guidelines,pilates mallorca website,clean ui purple" "Brand guidelines" "A clean white-and-purple identity with conversion-focused UI on mobile and desktop." "
<ul class='list'>
  <li>Colors: #6E44FF, #9B7BFF, #FFFFFF, #F7F7FB, #1A1A1A</li>
  <li>Typography: Manrope for headings, Source Sans 3 for body</li>
  <li>Style: simple cards, light shadows, high contrast text</li>
  <li>Mobile pattern: sticky bottom CTA and compact card grids</li>
</ul>
"

write_page "faq/index.html" "FAQ | Reformer Pilates Mallorca" "Answers to common questions about classes, pricing, and getting matched in Mallorca." "https://pilatesmallorca.com/faq/" "reformer pilates mallorca faq,pilates classes mallorca" "Frequently asked questions" "Quick answers before you choose your studio and teacher." "
<h2>Do I need experience?</h2><p>No. Beginner-friendly classes are available across Mallorca.</p>
<h2>Can I request German-speaking instructors?</h2><p>Yes, language is part of the signup filter.</p>
<h2>Is matching free?</h2><p>Yes, the user matching service is free.</p>
"

write_page "privacy/index.html" "Privacy Policy | Mallorca Reformer" "How Mallorca Reformer handles personal data and lead-routing information." "https://pilatesmallorca.com/privacy/" "privacy policy mallorca reformer" "Privacy policy" "We collect only the data required to deliver studio and teacher matches and support." "
<p>Data collected: contact details, location preferences, goals, and language preferences.</p>
<p>Purpose: lead matching and support communication.</p>
"

write_page "terms/index.html" "Terms of Use | Mallorca Reformer" "Terms governing the use of Mallorca Reformer directory and blog." "https://pilatesmallorca.com/terms/" "terms mallorca reformer" "Terms of use" "Using this website means you agree to our informational and listing terms." "
<p>Content is educational and not medical diagnosis. Consult qualified professionals for medical conditions.</p>
<p>Studio details are updated regularly but may change.</p>
"

mkdir -p blog

declare -a BLOGS=(
  "reformer-pilates-beginners-mallorca|Reformer Pilates for beginners in Mallorca|reformer pilates mallorca"
  "reformer-vs-yoga-mat-goals|Reformer vs yoga mat: which fits your goals?|reformer vs yoga mat"
  "pilates-breathing-basics|Best Pilates breathing basics|pilates breathing"
  "common-reformer-mistakes|10 common Reformer mistakes|reformer pilates tips"
  "pilates-for-back-pain-evidence|Pilates for back pain: what evidence says|pilates back pain"
  "pilates-for-posture|Pilates for posture improvement|pilates posture"
  "how-often-reformer-pilates|How often should you do Reformer Pilates?|reformer pilates frequency"
  "pilates-for-runners-mallorca|Pilates for runners in Mallorca|pilates for runners"
  "prenatal-pilates-safety|Prenatal Pilates basics (safety-first)|prenatal pilates"
  "postnatal-core-recovery|Postnatal core recovery with Pilates|postnatal pilates"
  "reformer-flexibility-timeline|Reformer for flexibility: realistic timeline|reformer flexibility"
  "reformer-strength-low-impact|Reformer for strength without high impact|reformer strength"
  "pilates-stress-management|Pilates and stress management|pilates stress"
  "home-mat-routine-complement|Home mat routine to complement Reformer|mat pilates routine"
  "private-vs-group-reformer|Private vs group Reformer classes|private vs group reformer"
  "nutrition-before-after-class|What to eat before and after class|pilates nutrition"
  "choose-pilates-teacher-mallorca|Choosing the right Pilates teacher|pilates teacher mallorca"
  "pilates-for-men-performance|Pilates for men: performance and mobility|pilates for men"
  "reformer-4-week-roadmap|Beginner 4-week Reformer roadmap|reformer beginner plan"
  "choose-studio-palma|How to pick a Pilates studio in Palma|pilates palma de mallorca"
)

for item in "${BLOGS[@]}"; do
  IFS='|' read -r slug title keyword <<<"$item"
  mkdir -p "blog/${slug}"
  {
    header "${title} | Mallorca Reformer Blog" "${title}. Practical guidance for Pilates users in Mallorca with evidence-backed notes and source links." "https://pilatesmallorca.com/blog/${slug}/" "${keyword},reformer pilates mallorca,pilates classes mallorca"
    cat <<HTML
<article class="hero article">
  <p class="breadcrumb"><a href="/">Home</a> / <a href="/blog/">Blog</a></p>
  <h1>${title}</h1>
  <p>Actionable tutorial for learners searching <strong>${keyword}</strong> in Mallorca. Use this guide to train more consistently and choose the right class format.</p>
</article>
<section class="section article">
  <h2>Key takeaways</h2>
  <ul class="list">
    <li>Start with quality cues and sustainable frequency over intensity spikes.</li>
    <li>Pick a class format aligned with your goal and movement background.</li>
    <li>Track progress with practical signals: control, breathing, and post-class recovery.</li>
  </ul>
  <h2>Practical framework</h2>
  <p>Use a 4-step loop: define your goal, choose the right studio profile, train 2-3 times weekly, then review outcomes every two weeks. If your target is postural strength or low-impact conditioning, Reformer classes can offer controllable loading and coach feedback. If your target is mobility and stress regulation, mat-based work can remain a strong complement.</p>
  <h2>Related pages</h2>
  <p><a href="/studios/">Browse all studios</a> · <a href="/compare/reformer-vs-yoga-mat/">Reformer vs yoga mat comparison</a> · <a href="/signup/">Get matched with a studio or teacher</a></p>
  <h2>Sources</h2>
  <ul class="list">
    <li><a href="https://www.who.int/news-room/fact-sheets/detail/physical-activity" target="_blank" rel="noopener">WHO: Physical Activity</a></li>
    <li><a href="https://pubmed.ncbi.nlm.nih.gov/24346291/" target="_blank" rel="noopener">Pilates and low back pain meta-analysis</a></li>
    <li><a href="https://pubmed.ncbi.nlm.nih.gov/32870936/" target="_blank" rel="noopener">Yoga interventions evidence review</a></li>
  </ul>
</section>
<script type="application/ld+json">
{
  "@context":"https://schema.org",
  "@type":"Article",
  "headline":"${title}",
  "author":{"@type":"Organization","name":"Mallorca Reformer"},
  "publisher":{"@type":"Organization","name":"Mallorca Reformer"},
  "mainEntityOfPage":"https://pilatesmallorca.com/blog/${slug}/"
}
</script>
HTML
    footer
  } > "blog/${slug}/index.html"
done

cat > robots.txt <<'TXT'
User-agent: *
Allow: /
Sitemap: https://pilatesmallorca.com/sitemap.xml
TXT

cat > sitemap.xml <<'XML'
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url><loc>https://pilatesmallorca.com/</loc></url>
  <url><loc>https://pilatesmallorca.com/studios/</loc></url>
  <url><loc>https://pilatesmallorca.com/studios/palma/</loc></url>
  <url><loc>https://pilatesmallorca.com/studios/calvia/</loc></url>
  <url><loc>https://pilatesmallorca.com/studios/alcudia/</loc></url>
  <url><loc>https://pilatesmallorca.com/studios/soller/</loc></url>
  <url><loc>https://pilatesmallorca.com/studios/andratx/</loc></url>
  <url><loc>https://pilatesmallorca.com/studios/map/</loc></url>
  <url><loc>https://pilatesmallorca.com/teachers/</loc></url>
  <url><loc>https://pilatesmallorca.com/teachers/reformer/</loc></url>
  <url><loc>https://pilatesmallorca.com/beginners/reformer-pilates-mallorca/</loc></url>
  <url><loc>https://pilatesmallorca.com/compare/reformer-vs-yoga-mat/</loc></url>
  <url><loc>https://pilatesmallorca.com/pricing/</loc></url>
  <url><loc>https://pilatesmallorca.com/about/</loc></url>
  <url><loc>https://pilatesmallorca.com/contact/</loc></url>
  <url><loc>https://pilatesmallorca.com/signup/</loc></url>
  <url><loc>https://pilatesmallorca.com/blog/</loc></url>
  <url><loc>https://pilatesmallorca.com/en/</loc></url>
  <url><loc>https://pilatesmallorca.com/de/</loc></url>
  <url><loc>https://pilatesmallorca.com/es/</loc></url>
  <url><loc>https://pilatesmallorca.com/sv/</loc></url>
  <url><loc>https://pilatesmallorca.com/brand/</loc></url>
  <url><loc>https://pilatesmallorca.com/faq/</loc></url>
  <url><loc>https://pilatesmallorca.com/privacy/</loc></url>
  <url><loc>https://pilatesmallorca.com/terms/</loc></url>
XML

for item in "${BLOGS[@]}"; do
  IFS='|' read -r slug _ <<<"$item"
  echo "  <url><loc>https://pilatesmallorca.com/blog/${slug}/</loc></url>" >> sitemap.xml
done

cat >> sitemap.xml <<'XML'
</urlset>
XML

cat > README.md <<'MD'
# Mallorca Pilates Website

Static, mobile-first SEO site scaffold for `pilatesmallorca.com`.

## Included
- 20+ core pages (directory, area pages, legal pages, conversion pages)
- 20 blog posts with source links and Article schema
- SEO essentials: canonical tags, meta descriptions, robots.txt, sitemap.xml
- Mobile-first UI (white + purple clean interface)

## Run locally
```bash
cd /Users/marianacarvalho/Documents/pilatesmallorca.com
python3 -m http.server 8080
```
Then open `http://localhost:8080`.

## Next production steps
- Connect signup form to CRM/backend
- Replace placeholder studio data with live directory source
- Add multilingual routes (`/es`, `/en`, `/de`) and hreflang alternates
- Add image optimization pipeline and CDN caching
MD

cat > BRIEFING-CODEX-GPT5.3.md <<'MD'
# Briefing for Codex + GPT-5.3

## Objective
Build and scale `pilatesmallorca.com` as the leading organic acquisition platform for Reformer Pilates in Mallorca and convert visitors into qualified leads.

## Focus keywords
1. pilates mallorca
2. reformer pilates mallorca
3. pilates palma de mallorca
4. reformer pilates palma
5. pilates classes mallorca

## Current build status
- Mobile-first static foundation implemented
- 15+ core pages live
- 20 blog articles generated
- Conversion pages and signup funnel included
- SEO base setup included (sitemap, robots, canonical, metadata)

## Next implementation priorities
1. Build CMS integration for studio and blog data
2. Add multilingual content strategy (ES/EN/DE) with hreflang
3. Add analytics and conversion tracking (GA4 + events)
4. Implement backend lead routing (studio/teacher matching)
5. Improve CWV: image CDN, preconnect fonts, critical CSS extraction

## Editorial rules
- Every health-related claim must include an authoritative source
- Keep educational tone, avoid diagnostic/medical promises
- Internal linking target: blog -> money pages -> signup
MD
