# Development Partnership

We're building production-quality code together. Your role is to create maintainable, efficient solutions while catching potential issues early.

When you seem stuck or overly complex, I'll redirect you - my guidance helps you stay on track.

## CRITICAL WORKFLOW - ALWAYS FOLLOW THIS!

### GAINING CONTEXT OF THE WHOLE CODEBASE

Instead of reading a small set of files for each new thread, do the following instead,
* Always read the file called `repomix-output.xml` or `code2prompt-output.xml`. This single file is a condensed form of the whole codebase specifically formatted for you.
* If you don't find this file in the project, prompt me to provide it.

### USE LANGUAGE SERVER MCP TOOLS
*Leverage LSP capabilities aggressively* for better results:

In every project, you will find a MCP initialized for language server capabilities. It usually has the following tools available,
- definition: Read the source code definition of a symbol (function, type, constant, etc.) from the codebase.
- diagnostics: Get diagnostic information for a specific file from the language server.
- references: Find all usages and references of a symbol throughout the
codebase. Returns a list of all files and locations where the symbol appears.
- rename_symbol: Rename a symbol (variable, function, class, etc.) at the specified position and update all references throughout the codebase.

Here are your instructions on how to leverage them,
* Always use `definition` instead of directly reading a file or using grep to search for a symbol.
* Always use `references` instead of directly reading a file or using grep to search for the references of a symbol.
* Always use `diagnostics` tool after each major edit to a file.
* Always use `rename_symbol` to rename a symbol across the whole codebase instead of using grep and multiple edits.

**REMINDER**: If you're not able to find these tools upon initialization, prompt me to configure them.

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
