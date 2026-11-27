# Introduction

Hey, I'm Mitch. I'm the Head of Engineering but still spend WAY too much time in the code. That's life though eh. I do coding both at work (for "Xemplo") and outside of work on personal projects (like "Chorus"), and use AI agents pretty extensively as I go.

If I'm in here coding though, the things that always matter a lot to me are:
* Simplicity ("KISS" and "YAGNI" principles)
* Reusability (generic, reusable classes and components are always preferred). If a second thing needs a feature that already lives somewhere else, generalise the existing one (e.g. one store keyed by owner) rather than building a parallel copy.
* General over localised. If the problem exists outside the case in front of you, solve it generally; a feature-scoped rule is usually just an extra condition.
* Cleaner over smaller. Lead with the clean fix, not the tiny patch. If the client is sending the server something the server already knows, that's the bug.
* I want my team (and my agents) to **care**. Leave things in a better state than you found it. Keep formatter/linter cleanup near what you're touching, in its own commit. Drift in unrelated areas gets offered as its own PR.

Please please PLEASE don't over-comment our code. Structured xmldoc/jsdoc is for public APIs only (see Code Comments), and inline code comments are almost never needed. If more than 1% of your code file is inline code comments, you've probably done something wrong.

## Communicating

### General Responses

I'm a human, and I'm a pretty casual guy. Speak to me accordingly. Thanks!

Things I like:
* Short, explanatory dotpoints
* A "TLDR" at the end of your message for anything long enough to need one
* Concrete yes/no responses. Short, punchy and to the point!

Things I hate:
* Long, overly-explanatory responses (if I want you to elaborate, I'll ask for it explicitly)
* Flowery, formal language (just give it to me straight, mate!)

**IMPORTANT:** I literally will not read more than a few sentences or dot-points. Never communicate to me in large slabs of text.

How I work with you:
* If I'm asking questions, answer them and stop. A slash command, a mode switch or a follow-up question is not a "go". No building until I say so or agree to a plan you offered.
* If I agree with or confirm something, that topic is closed. If something you've seen seems to conflict, mention it in one line and let me choose. Don't go investigating.
* Starting a new task? Say which one and why in one line, then start.
* If something runs well past what I'd expect, tell me within minutes: what phase it's in and whether it's alive or stuck. Don't wait for me to ask.
* Ask me before adding, removing or widening a standing rule you came up with yourself (in a shared brief, an instructions file or a memory). Rules I state can be recorded directly. A wrong standing rule costs on every single run.

### Technical Comms

For commit messages, I prefer conventional commits for most commits, but it is worth following the style already laid down in the repository if there is an obvious pattern.

Pull requests should follow my general communication preferences, around being casual, short and explanatory. If I'm not willing to read a three paragraph pull request, then I won't expect others to review it either. About five short dotpoints is the cap: what changed, what got riskier, one line of proof, anything out of scope.

Design proposals are prose that argues a position: what it's for, the shape of the solution, decisions with their reasons, open decisions and what we're not doing. Requirement tables wait until the design is agreed.

### Code Comments

**IMPORTANT:** DO NOT blindly follow commenting conventions of the current codebase. Keep your comments minimal.

The default is no comments at all. Structured docs go on public APIs only, and only where a caller can't work out the contract from the signature. No docs on tests (the name is the statement) or private members. Inline comments are for a genuine trap a competent reader wouldn't spot. If a comment would make sense in a PR description, it belongs in the PR.

Code documentation should *only* represent the current state, and should never have historical decision making chatter in it. It should *never* refer to work item codes, requirement IDs, decision codes, or anything along those lines.

Before committing, and again over the whole branch diff before marking a PR ready, grep for added comment lines across every language it touches, and read each match. When briefing sub-agents, spell this out; they copy the density of whatever they read.

## Workflows

I'm fine with you using sub-agents. If you're running in Paseo, you can also use cross-provider Paseo agents as much as you like. You have my explicit permission.

* Parallelise authors and reviewers. Launch unblocked work together. When running an agreed plan, start tasks as soon as their blockers clear rather than reporting and waiting.
* Keep an eye on delegates; don't fire and forget. If a delegate's work is committed and verified but it's still polishing, interrupt it and finish the tail yourself.
* Any background task that gates a push gets a follow-up check. Wait loops must not `pgrep -f` a pattern, because loops match each other's command lines and spin forever. Match an exact process name (`pgrep -x`).
* `pkill -f <pattern>` from a shell tool can match the tool's own wrapper and kill it, silently skipping the rest of the command. Kill by PID, or in its own call.

### Code Reviews

Before raising a new pull request, always get an independent review agent to review your changes. Quality is important to me!

* Split review by dimension (correctness/security, tests that actually test, docs versus code) and run the reviewers concurrently. Merge and de-dupe their findings before they go to the author.
* Independent means fresh agents given the PR and the problem, not your reasoning. In Claude Code, `/code-review` forks your own context, so it's only a self-check.
* Reviewers that mutate code each get their own worktree or detached checkout. Sharing one, they read each other's half-applied changes as real failures.
* Review tooling and worktree-isolated sub-agents can leave you on another branch or a detached HEAD. Run `git branch --show-current` before committing fixes.
* Fix findings in the PR that surfaced them, including pre-existing gaps the review found. Don't spin off new tickets, and don't invent work beyond what the review found. If something genuinely can't ship there, list it in the PR.

### Pull Requests

* Keep PRs under ~1.5k changed lines including tests. Plan the split up front and stack them.
* Push once, when the branch is finished and verified locally. Every push burns CI minutes. Review fixes get committed locally and pushed together.
* Stage by path, never `git add -A` or `git add .`. Sub-agents leave scratch files around. Check the `git diff --stat` file list matches the task before pushing.
* Ready means every non-skipped check in `statusCheckRollup` is green. `mergeable` only means there's no conflict.
* Scale verification to the change. A trivial fix gets a quick check of the actual symptom, minutes not an hour. Save the heavy bar (multi-viewport measurement, mutation matrices, e2e, repeated runs) for risky stuff: auth, data, migrations, shared libraries.
* Upgrades cover versions, warnings, vulnerable packages and the practices the new versions recommend. Put the best-practice adoption in its own stacked PR.

### Stacked PRs

* Stack anything with a merge order, including PRs that touch the same files or append to a shared registry. Squash merges will conflict them otherwise.
* Base each PR on the branch that merges before it, and, where `gh stack` is available, link every one with `gh stack link --base <default branch> <bottom> <next> ...`. An unlinked child can get closed rather than retargeted when its base merges.
* After a squash merge, children still carry the parent's old commits: `git rebase --onto origin/<default branch> <old parent head> <child>`, then `--force-with-lease=<child>:<child's pre-rebase head>`.
* I merge as soon as things go ready, so stacks move under you. `git fetch` and compare local and remote heads before pushing to any stacked branch. If they diverged, `git reset --hard origin/<branch>` and cherry-pick your new commits; never force-push over my rebase.

## Testing

* A new guard or review fix isn't proven until breaking it makes a test fail by name. Check each fix on its own, not once over the whole change.
* Mutation results lie. Confirm the file actually changed (CRLF breaks multi-line patterns), that it compiled (no test output is a build failure, not a survivor), that your filter includes the covering test, and that your parser can read the failure (strip ANSI). Keep mutation scripts in a private directory.
* Restore mutations with the exact inverse edit. `git checkout` wipes uncommitted fixes, and `mv` from a backup keeps the old mtime so the build stays stale. Patterns can match twice, so read `git diff HEAD` on non-test source afterwards; it should be just the intended change.
* Wrap mutations of loops, recursion or cycle detection in `timeout`. A runaway loop can OOM the whole machine.
* No assertions on the order of generated ids, dictionary enumeration or the clock. Compare as sets or sort by a stable key. Run new tests several times before pushing.
* Don't test static markup, like a hardcoded label rendering. Test the condition, not the content.
* Prove refactor parity with a throwaway run. Commit readable behaviour tests, never golden snapshots.
* Read the full test output. Runners can fail on unhandled errors with every test passing, and exit 0 when a project didn't compile.
* Fix leaks and test OOMs at the retainer, not with pool or isolation settings. Harnesses change.

### Browser Checks

* Green unit tests don't close a UI bug, because the mocks share your misunderstanding. Open the real page, reproduce the symptom, then watch it clear. If you touched a shared control, check another consumer too.
* For layout changes, check geometry, not ARIA or class state. Measure `getBoundingClientRect()` on the trigger and the surface and check for ancestor `overflow` or `transform` clipping. For risky layout work, measure at the extremes: first and last items, narrow viewport, long text.
