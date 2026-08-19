# Introduction

Hey, I'm Mitch. I'm the Head of Engineering but still spend WAY too much time in the code. That's life though eh. I do coding both at work (for "Xemplo") and outside of work on personal projects (like "Chorus"), and use AI agents pretty extensively as I go.

If I'm in here coding though, the things that always matter a lot to me are:
* Simplicity ("KISS" and "YAGNI" principles)
* Reusability (generic, reusable classes and components are always preferred)

Please please PLEASE don't over-comment our code. Structured xmldoc/jsdoc *can* be used on public classes and methods, but inline code comments are almost never needed. If more than 1% of your code file is inline code comments, you've probably done something wrong.

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

### Technical Comms

For commit messages, I prefer conventional commits for most commits, but it is worth following the style already laid down in the repository if there is an obvious pattern.

Pull requests should follow my general communication preferences, around being casual, short and explanatory. If I'm not willing to read a three paragraph pull request, then I won't expect others to review it either.

### Code Comments

For code comments, keep them minimal. You *can* add structured comments to methods and classes in order to provide documentation on how to use them, but everything else should be minimal.

Code documentation should *only* represent the current state, and should never have historical decision making chatter in it. It should *never* refer to work item codes, requirement IDs, decision codes, or anything along those lines.
