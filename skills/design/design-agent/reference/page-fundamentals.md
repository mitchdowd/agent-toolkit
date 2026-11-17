# Page fundamentals

## Read the request first

Decide the treatment; designing is a given. Many requests call for a
utilitarian treatment (a plan, a memo, an admin screen, a demo): polished,
with real typographic hierarchy, considered spacing and a proper palette, but
not over-designed. Some call for an editorial treatment (a landing page, a
game, something to share). If unsure, a well-composed page is always
acceptable; an over-designed visual identity sometimes isn't.

## Fundamentals

**Respect what already exists.** Look for an existing design system first:
CLAUDE.md, a tokens or theme file, existing component styles. When one exists,
apply it; everything below fills gaps and never overrides. Precedence: the
user's own words, then the project's existing system, then your choices.

**Ground it in the subject.** One concrete subject, its audience, and the
page's single job. Include at least one detail only this subject would have
(its real units, document conventions, terms of art) as content, not ornament.
Real content throughout, never lorem ipsum.

**Pair typefaces.** Inter for text and Space Grotesk for headings are good
defaults when nothing calls for other type. Declare a real fallback stack.
Keep running text near 65 characters wide. Set a type scale and keep to it.
`text-wrap: balance` on headings; a little letter-spacing on uppercase labels.

**Choose neutrals deliberately.** A grey with a slight hue bias toward the
accent looks intentional; a pure mid-grey looks unconsidered.

**Design both themes.** Define every color as a token on `:root` (light
values), redefine only the tokens under
`@media (prefers-color-scheme: dark) { :root:not([data-theme="light"]) {…} }`
and again under `:root[data-theme="dark"]`, with `color-scheme: dark` in both.
Never give a color its only definition inside a media or `[data-theme]` block;
never use a literal color in a component rule that reads in one theme only.
Give the second theme the same care as the first: don't simply invert it.

**Use layout for spacing.** Sibling groups get flex or grid with `gap`, not
per-element margins. A side gutter of at least 16px at every width. Rows wrap
or stack at phone width (~400px). Images and aspect-ratio boxes get
`max-width: 100%`; nothing gets a `min-width` wider than the screen. Only wide
tables, code and diagrams may exceed the width, each in its own
`overflow-x: auto` container. Any flex/grid child holding text, code or a table
gets `min-width: 0`. `font-variant-numeric: tabular-nums` where digits line up.

**Make repeated elements consistent.** Same edges, baselines and inner padding
on sibling cards, rows and badges; recurring elements in the same place on each.
Let content set height; pick a column count the items fill. Text that can
outgrow its track wraps or scrolls in its own container; clipped text is a bug.

**Use card styling selectively.** Border, fill, radius and shadow mark an
element as a separate object. Apply them by role; the same radius and shadow on
every block flattens the hierarchy. Big-number tiles only when those figures
are the point.

**Draw charts to scale.** One scale for marks, ticks and labels; every label
names a value the chart reaches; chart text colored from theme tokens; marks
and labels clear of each other and inside the bounds.

**Make the page complete at rest.** Everything meant to be read is visible on
load. A tool opens in a realistic working state (sample rows, a filled form),
clearly marked as examples, never an empty shell.

**Avoid AI-generated design.** It clusters around: warm cream (#F4F1EA) with a
serif display and terracotta accent; near-black with a lone acid-green or
vermilion pop; broadsheet hairline rules with dense columns; a purple-to-blue
gradient hero; emoji as section markers; everything centered; `rounded-lg`
everywhere; accent bar on rounded cards. Follow the user's direction exactly
when they give one; otherwise don't spend freedom on these.

**Build cleanly.** Watch for overlapping elements, cascade collisions and
silent font fallbacks. Visible keyboard focus; respect
`prefers-reduced-motion`. Watch selector specificity: a type selector
(`.section`) and an element selector (`.cta`) both setting spacing will cancel
each other unnoticed.

**Writing the copy.** Words are design material. Name things by what people
recognize, not how the system is built (people manage *notifications*, not
*webhook config*). Active voice; a control states exactly what happens
("Publish", then "Published"). Errors explain what went wrong and how to fix
it, without apologies. Prefer specific to clever. Avoid em-dash asides, "not
X, but Y", colon-then-reveal sentences, scare quotes and stock phrases.

**Structure is information.** Numbering, eyebrows, dividers and labels must
encode something true about the content. Numbered markers only for real
sequences.

**When the page is a UI (dashboard, tool, admin screen).** It is scanned and
operated, so the craft shifts from typography to information design. Summary
before detail. Encode state in form as well as number (a pill, a chip, a
severity stripe) so what needs attention is visible at a glance. Semantic color
(good / warning / critical) is separate from the accent. Interactive elements
look interactive.

## Editorial requests

Make opinionated decisions and take one real aesthetic risk where it serves
the work. Review the plan against the subject before building; revise any part
that reads like the default you'd produce for any similar page. The hero states
the thesis. Typography sets the personality. One orchestrated motion moment
beats scattered effects. Put your boldness in one place; keep everything around
it quiet.
