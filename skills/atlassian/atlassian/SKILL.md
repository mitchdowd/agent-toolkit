---
name: atlassian
description: Jira, Confluence and Bitbucket Cloud operations via the Atlassian Rovo MCP server. Use whenever the user mentions Jira (issues, tickets, epics, sprints, JQL), Confluence, or Bitbucket (pull requests, PR comments, pipelines), or the git remote is on bitbucket.org.
---

# Atlassian via MCP

Use the Atlassian MCP server for all Jira, Confluence and Bitbucket work. Don't fall back to other CLIs (`acli`, `bkt`) or raw API calls.

## Workflow

1. Load the Atlassian MCP tools (e.g. tool search for `atlassian`). If there are none, tell the user to run `install.sh` from agent-toolkit and stop.
2. Get the `cloudId` with `getAccessibleAtlassianResources`. Every call needs it.
3. Call the tool directly if it's listed. Otherwise use `discover` to find it, then run it with `executeRead`, `executeWrite` or `executeDestructive` to match what it does. Bitbucket tools are usually only reachable this way, so a missing `*Bitbucket*` tool doesn't mean Bitbucket isn't supported.
4. Confirm with the user before destructive or bulk changes (merges, deletes, multi-issue updates).

## Jira

- Search with JQL via `searchJiraIssuesUsingJql`; read with `getJiraIssue`.
- Create and edit with `createJiraIssue`, `editJiraIssue`, `transitionJiraIssue`, `addCommentToJiraIssue`.
- Issue, ticket, story, bug and epic all mean a Jira issue.

## Bitbucket

- Get the workspace and repo slug from `git remote get-url origin`. Use plain `git` for local work; use the MCP for anything server-side.
- Read: `listBitbucketRepoPullRequests`, `getBitbucketRepoPullRequest`, `getBitbucketRepoPullRequestDiff`, `listBitbucketRepoPullRequestComments`, `getBitbucketRepoFileContent`, `listBitbucketRepoPipelines`, `getBitbucketRepoPipelineStepLog`
- Write: `createBitbucketRepoPullRequest`, `updateBitbucketRepoPullRequest`, `addBitbucketRepoPullRequestComment`, `resolveBitbucketRepoPullRequestComment`, `approveBitbucketRepoPullRequest`, `requestChangesOnBitbucketRepoPullRequest`
- Destructive: `mergeBitbucketRepoPullRequest`

## Troubleshooting

- No Bitbucket workspaces: the workspace must be linked to an Atlassian organization, with the `read_bitbucket` / `write_bitbucket` permission groups granted.
- Auth errors: ask the user to re-authenticate (`/mcp` in Claude Code, `codex mcp login atlassian` in Codex).
