# Designing well

The reasoning and detail behind SKILL.md's short rules.

### Settle the aesthetic with the user, not for them

Without an aesthetic, references, or a design system from the user,
get their input before committing (within SKILL.md's rules on asking),
or sketch 2–4 genuinely different low-fi directions they can SEE,
rather than quietly picking your own aesthetic (this is how you get slop). A concrete
subject, asset or brand IS input; with nobody to ask, commit to one
nameable direction and say so rather than ending on a question. Once
settled, a decision stays settled. Then commit to a small system:

- A type pairing: for new work in Latin script with no brand or design
  system, type from the brief and subject; if neutral (apps, data), Inter for text and Space Grotesk for headings. Work added to an existing design keeps
  its faces. 1–3 families, each with a system fallback of close
  metrics.
- Foreground/background: a color tone (warm, cool, neutral); subtly
  toned whites and blacks (whites below 0.02 saturation).
- Accents: 0–2, in oklch, sharing chroma and lightness, varying hue.
  Prefer the brand or design system's colors; if too restrictive,
  derive harmonious oklch colors from them rather than inventing new.

### Hi-fi mockups are rooted in context

Good hi-fi designs do not start from scratch — they are rooted in
existing design context: the user's codebase or repo, brand assets,
screenshots of the existing product, an attached design system. Spend
time acquiring that context before designing, and ask the user for it
if you can't find it. Mocking a full product from scratch is a LAST
RESORT and will lead to poor design. State your assumptions, context,
and design reasoning early, and show work to the user as soon as
there is something to react to.

If you do not have an icon, asset, or component, draw a placeholder:
in hi-fi design, a placeholder is better than a bad attempt at the
real thing.

### Variations and options

- When a direction decision is still open (overall direction, hero
  layout, type pairing, color stance, density), settle it BEFORE
  building the full deliverable. Offer 2–4 genuinely different
  candidates, each exploring an axis you can name ("Warm editorial" vs
  "Dense data-first") — five shades of one aesthetic is no choice at
  all. Decision fidelity is not deliverable fidelity: low-fi sketches are enough to pick a direction.
- Give each option an honest motivation and its main tradeoff, in your
  reply, not on the design itself — a set where only your favorite gets a
  case made for it is a rigged vote.
- Keep option names stable: once an option is "Option B" or
  "Warm editorial", it keeps that identity — never renumber or rename
  options across turns.
- When the direction is settled and the user wants variations to keep,
  give 3+ across several dimensions — by-the-book designs that match
  existing patterns alongside novel interactions, layouts, metaphors
  and visual styles; remix the brand's visual DNA (scale, fills,
  texture, rhythm, layering, type treatments). The goal is atomic
  variations the user can mix and match, not the perfect option.
- For early exploration, wireframe: breadth over polish, 3–5 distinct
  approaches per idea, simple shapes, placeholder text, minimal color
  — sketchy, low-fi, focused on structure and flow.

### Appropriate scales

Touch targets on phone layouts are never less than 44px. For print,
12pt is the minimum body type. Text in any design is sized for its
real viewing distance.

### Accessible as drawn

Draw controls with real elements even in a static mockup: `<button>`,
`<a href>`, and `<input>` with a `<label>`. A div or span with `role` or
`onClick` looks the same, but Tab skips it. Give an icon-only button an
`aria-label`. SVG: decor `aria-hidden="true"`, else
`role="img" aria-label`. Keep text at a contrast of at least 4.5:1
against what is behind it (3:1 from 24px). Caption grey and coloured
fills under white text fail most often: darken both. Colors that must be
told apart also differ in lightness, not hue alone; prefer blue/orange to
red/green.

### Landing pages

Build with marketing-page anatomy: a hero that states the offer in one
sentence with one clear call to action; proof the visitor can trust
(testimonials, client logos, numbers — drawn from the user's material,
or visibly marked placeholders); benefit sections that answer a
visitor's actual doubts rather than listing features. One primary
action per page, repeated down the page — not three competing buttons.

For a landing page, the copy is the product. Write specific copy
grounded in what the user told you — their product, their customers,
their voice. Never lorem ipsum, never "Welcome to our website", never
interchangeable marketing filler that could describe any business.
Where a real fact is missing (a price, a date, an address), put in a
visibly marked placeholder like [YOUR PRICE] for the user to fill —
don't fabricate one.

### Mobile prototypes

No fake chrome: do NOT draw a fake iOS status bar (the "9:41 ·
battery · wifi" strip) or a fake virtual keyboard. On a real phone
the real status bar and keyboard render on top of your layout — a
painted fake looks doubled up and childish. Leave that space alone.

### Recreating an existing UI

When the user asks to recreate a UI whose source you can reach — a
repo checkout, pasted files, an attached design system — build from
the real source, not your training-data memory of the app: explore
what exists, read the components and styles, and copy the assets the
page actually loads (icons, fonts, images, stylesheets — not
bundler-only component source). Copy exact numeric values — paddings,
radii, font sizes, line-heights — from the source; never round or
snap them to a 4/8-px grid or a framework default. You're better
at recreating and editing interfaces from code and design context
than from screenshots: when source is available, treat screenshots as
high-level guidance only. If you can't read the source, stop and say
so rather than inventing from memory. (The copyrighted-designs rule below governs whether to recreate at all.)

## Content rules

- **Do not add filler content.** Never pad a design with placeholder
  text, dummy sections, or informational material just to fill space.
  Every element should earn its place. If a section feels empty, that's
  a design problem to solve with layout and composition — not by
  inventing content. One thousand no's for every yes. Avoid "data slop"
  — unnecessary numbers, icons, or stats that are not useful. Less is
  more; bias towards minimalism.
- **Ask before adding material.** Beyond the states a brief implies,
  if you think additional sections, pages or copy would improve the
  design, suggest them rather than adding them unilaterally. The user knows their audience and
  goals better than you do.
- **Do not recreate copyrighted designs.** If asked to recreate a
  company's distinctive UI patterns, proprietary command structures, or
  branded visual elements, refuse unless the user works at that
  company (ask when it's unclear). Instead, understand what they want
  to build and help them create an original design.
