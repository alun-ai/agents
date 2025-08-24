# Claude Code Agents Collection

A comprehensive collection of specialized AI agents for Claude Code, designed to streamline development workflows through intelligent task delegation and coordinated execution.

## Overview

This repository contains specialized Claude Code agents that work together to handle complex software development projects. Each agent is designed with specific expertise areas and can be invoked using the `@agent-name` pattern to delegate tasks requiring specialized knowledge.

Planning and reviewing agents are configured to use **Claude Opus 4.1** (`opus`) for maximum capability and consistency across complex development tasks.

## Agent Categories

### Core Development Agents
- **`code-archaeologist`** - Expert at exploring, understanding, and documenting any codebase
- **`code-reviewer`** - Expert code reviewer ensuring quality, security, and maintainability
- **`continuous-code-reviewer`** - Proactive code review during development with architectural improvements
- **`documentation-specialist`** - Expert technical writer for comprehensive documentation
- **`performance-optimizer`** - Performance optimization expert for system bottlenecks

### Orchestrator Agents
- **`friday`** - Intelligent task router and communication proxy that delegates to all specialized agents
- **`project-manager`** - Expert project manager coordinating large-scale engineering projects
- **`github-manager`** - Expert GitHub issue orchestrator for task and investigation management
- **`jira-manager`** - Expert Jira ticket manager with component-based routing and agent delegation
- **`tech-lead-orchestrator`** - Senior technical lead providing strategic implementation recommendations
- **`project-analyst`** - Expert team member understanding project architecture and patterns

### Database Specialists
- **`database-engineer`** - Full-stack database expert for PostgreSQL and MySQL - schema design, optimization, migrations

### Language & Framework Specialists
- **`python-engineer`** - Comprehensive Python developer across multiple frameworks
- **`typescript-engineer`** - TypeScript backend developer with Node.js expertise
- **`elixir-engineer`** - Elixir systems expert using OTP, Phoenix, LiveView, and BEAM patterns
- **`react-engineer`** - Full-stack React specialist for components and Next.js with SSR/SSG capabilities
- **`react-state-manager`** - Expert in React state management solutions

### Specialized Experts
- **`seo-optimizer`** - Expert in search engine optimization and organic traffic
- **`chief-of-staff`** - Expert in DevOps metrics and engineering analytics

## Development Workflow Patterns

### Install the agents
```
cd ~/.claude
cp -Rf agents ~/.claude/
```

**Copy the .mcp.json into your project**
- I would suggest adding it to your .gitignore
```
cp -Rf ~/.claude/agents/.mcp.json.example .
```

**Install github and jira cli**
```
brew install gh
brew install jira-cli
```

## WORKFLOW

### Using Friday as Your Task Router

For general development tasks, you can use Friday as your primary interface:

```
@friday [your request or task]
```

Friday will analyze your request and automatically route it to the appropriate specialist agents. Examples:

- "The dashboard is loading slowly" → Routes to performance-optimizer
- "Add dark mode to the app" → Routes to react-engineer
- "Fix the login bug" → Routes to code-archaeologist → appropriate engineer
- "Review my code for security" → Routes to code-reviewer
- "Document the new API" → Routes to documentation-specialist

### 0. Create a new feature branch
```
<Create a new feature branch for all new development>
```

### 1. Feature Planning & Design
**Turn on Plan Mode:**
```
<Discussion about the feature and the goal with obstacles>
<Add all relevant architecture or previous documentation>
<Once done with discussion, run the next prompt>
```

**Create High-Level Plan:**

> Create the high level plan (epic) of this feature I have no users, the product and platform are in full stealth. You now have access to the code and are the only developer.  Documentation should be documented in ./docs/issues/<github-issue-id>. Perform a deep technical analysis to determine what you would need to build and add to implement this feature. Create a detailed product plan only, and use @agent-project-manager and @agent-github-manager to document the entire epic in GitHub as a github issue.  No implementation of this plan should start until I have given approval.


### 2. Detailed Implementation Planning

**Create Issued Approach:**

> @agent-project-manager Coordinate this plan using <github issue> as the explicit source of truth. Use ultrathink and sequential thinking to produce a comprehensive PRD with dependencies, risks, and acceptance criteria, quality gates, do NOT over engineer. Claude Code is the sole developer, there are no humans or teams to work with or plan for.  All timing and projects should be based on Claude developing the feature.  Coordinate with agents to research, analyze, validate, and propose actions. Create GitHub issues via @agent-github-manager with the full PRD using the GitHub CLI. We are not in a hurry, take the time needed to design the best solution, do not optimize for simple or to get it done. Do not execute any changes until all planning issues are completed and reviewed. Prioritize quality, clear structure, and maintainability. Once all PRDs are created, have the @code-archeaologist review the PRD for any technical limitations, considerations or risks.  Await for user review before proceeding.


### 3. Implementation Execution

**Begin Implementation:**

> @agent-project-manager Begin implementation with the agent team. Ensure each agent uses ultrathink and sequential thinking to perform their tasks. Do not advance to the next issue until the current issue's code is implemented, reviewed, optimized, and verified with code reviews against our quality gates.  Have both @code-archaeologist and @code-review review all code before proceeding. Update the tracking issue with progress via @agent-github-manager.
> .


**Continue Each Issue:**

> @github-manager Update the github issues with progress. Re-read the next issue to ensure the work stays on scope and is explicitly followed. @project-manager have the agents continue implementation of only the documented issue.  Coding tasks should be delegated to specialized agents.

**Issue Complete:**

> @github-manager Update the github issues with progress. Re-read the next issue in the implementation plan to ensure the work stays on scope and is explicitly followed. @project-manager have the agents continue implementation of only the next documented issue.

### 4. Code Review & Quality Assurance

**Perform QA and bug remediation**

> @agent-project-manager Now need to do a full QA builds, error messages, console errors and bugs.  Start with running the build and starting the app to ensure no errors. Check for any type and lint errorrs, ensure we have a full clean build.

**Create a feature review branch off your feature branch**
This ensures all changes can be review in isolation and can be thrown away if things go sideways

**Comprehensive PR Review:**
- PR Review - after a feature is done and before PR is merged

> @agent-project-manager Coordinate a full code review of this branch. Do not assume the documentation (./docs/<folder>) or github issues are up to date or were used as fact. Use @agent-code-reviewer and @agent-github-manager to create and update an issue with all findings, opportunities, and issues. Delegate tasks to subagents. This PR or branch could have redundant, over-engineered, verbose code that likely needs unification, refactored for re-usability, or cleaned up. Do not delete empty database tables, but check to make sure all database migrations are completed. Create a systematic plan using ultrathink and sequential thinking to identify key refactoring areas aligned with modern best practices. Use context7 and Serena MCP to reference and update all code documentation. This PR may have many side paths and duplicate workflows, so ensure a thorough and organized review. Github issues are:

**Fix issues found:**

> @agent-project-manager Begin fixing the issues outlined in these new tickets with the agent team. Ensure each agent uses ultrathink and sequential thinking to perform their tasks. Do not advance to the issue until the current issue's code is implemented, reviewed by me, optimized, and verified with a code review from the @code-archaeologist. Update the issue tracking with progress via @agent-github-manager. It is critical to enforce the code reviews and checklist sign off before any issue transition.  Remember to check if serena is available and use for references.

**Continue Review:**
> Proceed to have @agent-code-archaeologist review.

### 5. Organize Commits and Issues
- Commit, create branch, open PR and link all issues.

> @agent-project-manager @agent-github-manager update all issues with completion status.  Commit all changes, push to branch and open PR and link PR to issues


## Key Features

### Memory & Context Management
- **Persistent Memory**: All agents leverage MCP Memory for maintaining context across sessions
- **Sequential Thinking**: Complex tasks use structured sequential thinking for systematic analysis
- **Ultrathink Integration**: Deep analysis capabilities for multi-step problem solving

### Agent Coordination
- **Orchestrated Workflows**: Project managers coordinate multiple specialists
- **Issue Tracking**: Automated GitHub issue creation and management
- **Quality Gates**: Enforced code review and testing requirements between issues

### Development Best Practices
- **Database Safety**: Always check environment variables before running queries
- **Code Quality**: Prefer editing existing files over creating new ones
- **Documentation**: Only create docs when explicitly requested
- **Security**: Consider security implications of all changes
- **Testing**: Maintain test coverage for new features

## Agent Communication Patterns

### Direct Agent Invocation
```
@agent-name [specific task or context]
```

### Multi-Agent Coordination
```
@agent-project-manager Coordinate with @agent-code-reviewer and @agent-github-manager to [task]
```

### Context-Aware Delegation
Agents can delegate to other specialists when encountering tasks outside their expertise:
- Security issues → `security-guardian` (if available)
- Performance problems → `performance-optimizer`
- Major refactoring → `refactoring-expert` (if available)

## Configuration

### Model Configuration
Some agents are configured to use Claude Opus 4.1:
```yaml
model: opus
```

### Tool Access
Agents have access to appropriate tools based on their specialization:
- **Core agents**: Read, Grep, Glob, Bash, LS
- **Specialized agents**: Framework-specific tools and integrations
- **Orchestrators**: Full tool access for coordination

## Best Practices

### When to Use Agents
- **Complex multi-step tasks** requiring specialized knowledge
- **Code reviews** before merging significant changes
- **Architecture decisions** needing expert analysis
- **Performance optimization** requiring systematic analysis
- **Project coordination** across multiple work streams

### Agent Selection Guidelines
1. **Start with orchestrators** (`project-manager`, `github-manager`) for complex projects
2. **Use specialists** for language/framework-specific tasks
3. **Leverage reviewers** before finalizing implementations
4. **Coordinate through project managers** for multi-issue work

### Quality Assurance
- All issues require code review before advancement
- GitHub issues track progress and findings
- Sequential thinking ensures systematic problem solving
- Memory maintains context across development sessions

## Contributing

### Agent Development
Follow the `AGENT_TEMPLATE.md` for creating new specialized agents:
- Define clear expertise areas
- Specify appropriate tools
- Include delegation patterns
- Document usage examples

### Workflow Improvements
Contribute workflow patterns and prompt templates that improve development efficiency and code quality.

