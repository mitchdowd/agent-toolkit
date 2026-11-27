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

How I want you to work with me:
* If something runs well past what I'd expect, tell me within minutes: what phase it's in and whether it's alive or stuck. Don't wait for me to ask.
* Don't create standing rules without my approval.

### Technical Comms

For commit messages, I prefer conventional commits for most commits, but it is worth following the style already laid down in the repository if there is an obvious pattern.

Pull requests should follow my general communication preferences, around being casual, short and explanatory. If I'm not willing to read a three paragraph pull request, then I won't expect others to review it either.

### Code Comments

**IMPORTANT:** DO NOT blindly follow commenting conventions of the current codebase. Keep your comments minimal.

The default is no comments at all. Structured docs go on public APIs only, and only where a caller can't work out the contract from the signature. No docs on tests (the name is the statement) or private members. Inline comments are for a genuine trap a competent reader wouldn't spot. If a comment would make sense in a PR description, it belongs in the PR.

Code documentation should *only* represent the current state, and should never have historical decision making chatter in it. It should *never* refer to work item codes, requirement IDs, decision codes, or anything along those lines.

## Workflows

I'm fine with you using sub-agents. If you're running in Paseo, you can also use cross-provider Paseo agents as much as you like. You have my explicit permission.

* Parallelise authors and reviewers. Launch unblocked work together. When running an agreed plan, start tasks as soon as their blockers clear rather than reporting and waiting.
* Check in on sub-agents regularly rather than firing and forgetting. If one has finished the real work but is still polishing, stop it and wrap up yourself.

### Code Reviews

Before raising a new pull request, always get an independent review agent to review your changes. Quality is important to me!

* Split review by dimension (correctness/security, tests that actually test, docs versus code) and run the reviewers concurrently. Merge and de-dupe their findings before they go to the author.
* Independent means fresh agents given the PR and the problem, not your reasoning. In Claude Code, `/code-review` forks your own context, so it's only a self-check.
* Reviewers that mutate code each get their own worktree or detached checkout. Sharing one, they read each other's half-applied changes as real failures.
* Review tooling and worktree-isolated sub-agents can leave you on another branch or a detached HEAD. Run `git branch --show-current` before committing fixes.
* Fix findings in the PR that surfaced them, including pre-existing gaps the review found. Don't spin off new tickets, and don't invent work beyond what the review found. If something genuinely can't ship there, list it in the PR.

### Pull Requests

* Keep PRs under ~1.5k changed lines including tests. Plan the split up front, and base each PR on the branch that merges before it.
* Push once, when the branch is finished and verified locally. Every push burns CI minutes. Review fixes get committed locally and pushed together.
* Stage by path, never `git add -A` or `git add .`. Sub-agents leave scratch files around. Check the `git diff --stat` file list matches the task before pushing.
* A PR isn't ready until CI is green. "No conflicts" isn't the same thing.
* Scale verification to the change. A trivial fix gets a quick check of the actual symptom, minutes not an hour. Save the heavy bar (multi-viewport measurement, mutation matrices, e2e, repeated runs) for risky stuff: auth, data, migrations, shared libraries.
* Upgrades cover versions, warnings, vulnerable packages and the practices the new versions recommend. Put the best-practice adoption in its own stacked PR.
* Stacked branches move under you, because I merge as soon as things go ready. Fetch and compare with the remote before pushing, and never force-push over someone else's rebase.

## Testing

* Prove a new test actually tests something: break the code it covers and check that it fails. Do the same for each review fix.
* Don't assert the order of things that have no real order, like generated ids, dictionaries or timestamps. They pass locally and fail randomly in CI.
* Don't test static content, like a hardcoded label. Test the logic.
* Proving a refactor didn't change behaviour? Use a throwaway comparison run. Only commit readable behaviour tests.
* Read the whole test output, not just the pass count. Runs can fail with every test passing.
* Fix memory leaks in tests at the source, not by tweaking test runner settings.

### Browser Checks

* Green unit tests don't close a UI bug, because the mocks share your misunderstanding. Open the real page, reproduce the symptom, then watch it clear. If you touched a shared control, check another consumer too.
* For layout changes, check geometry, not ARIA or class state. Measure `getBoundingClientRect()` on the trigger and the surface and check for ancestor `overflow` or `transform` clipping. For risky layout work, measure at the extremes: first and last items, narrow viewport, long text.
