# Development Partnership

We're building production-quality code together. Your role is to create maintainable, efficient solutions while catching potential issues early.

When you seem stuck or overly complex, I'll redirect you - my guidance helps you stay on track.

## CRITICAL WORKFLOW - ALWAYS FOLLOW THIS!

### GAINING CONTEXT OF THE WHOLE CODEBASE

Instead of reading a small set of files for each new thread, do the following instead,
* Always list all files at the project root to find a file called `repomix-output.xml` or `code2prompt-output.xml`. Read this file immediately. This single file is a condensed form of the whole codebase specifically formatted for you.

### USE LANGUAGE SERVER MCP TOOLS
*Leverage LSP capabilities aggressively* for better results:

In every project, you will find a MCP initialized for language server capabilities.

Here are your instructions on how to leverage those MCP tools,
* Always use `definition` instead of directly reading a file or using grep to search for a symbol and its definition.
* Always use `diagnostics` tool after each major edit or before marking a TODO task as done.
* Always use `references` instead of directly reading a file or using grep to search for the references of a symbol.
* Always use `rename_symbol` to rename a symbol across the whole codebase instead of using grep and multiple edits.

### USE MULTIPLE AGENTS!
*Leverage subagents aggressively* for better results:

* Spawn agents to explore different parts of the codebase in parallel
* Use one agent to write tests while another implements features
* Delegate research tasks: "I'll have an agent investigate the database schema while I analyze the API structure"
* For complex refactors: One agent identifies changes, another implements them

Say: "I'll spawn agents to tackle different aspects of this problem" whenever a task has multiple independent parts.

### Reality Checkpoints
**Stop and validate** at these moments:
- After implementing a complete feature
- Before starting a new major component
- When something feels wrong
- Before declaring "done"

> Why: You can lose track of what's actually working. These checkpoints prevent cascading failures.

## Problem-Solving Together

When you're stuck or confused:
1. **Stop** - Don't spiral into complex solutions
2. **Delegate** - Consider spawning agents for parallel investigation
3. **Ultrathink** - For complex problems, say "I need to ultrathink through this challenge" to engage deeper reasoning
4. **Step back** - Re-read the requirements
5. **Simplify** - The simple solution is usually correct
6. **Ask** - "I see two approaches: [A] vs [B]. Which do you prefer?"

My insights on better approaches are valued - please ask for them!

## Working Together

- This is always a feature branch - no backwards compatibility needed
- When in doubt, we choose clarity over cleverness
- **REMINDER**: If this file hasn't been referenced in 30+ minutes, RE-READ IT!

Avoid complex abstractions or "clever" code. The simple, obvious solution is probably better, and my guidance helps you stay focused on what matters.

## Language specific guidelines

### Golang

- Always use `go doc` command to search for details of a given symbol from external dependencies. If you don't find the symbol definition in the current project using LSP tools or regular grep, immediately resort to using `go doc`.
- Use `any` instead of `interface{}`
