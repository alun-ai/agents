# Claude Code Agents Collection

A comprehensive collection of specialized AI agents for Claude Code, designed to streamline development workflows through intelligent task delegation and coordinated execution.

## Overview

This repository contains specialized Claude Code agents that work together to handle complex software development projects. Each agent is designed with specific expertise areas and can be invoked using the `@agent-name` pattern to delegate tasks requiring specialized knowledge.

Planning and reviewing agents are configured to use **Claude Opus 4.1** (`claude-opus-4-1-20250805`) for maximum capability and consistency across complex development tasks.

## Agent Categories

### Core Development Agents
- **`code-archaeologist`** - Expert at exploring, understanding, and documenting any codebase
- **`code-reviewer`** - Expert code reviewer ensuring quality, security, and maintainability
- **`continuous-code-reviewer`** - Proactive code review during development with architectural improvements
- **`documentation-specialist`** - Expert technical writer for comprehensive documentation
- **`performance-optimizer`** - Performance optimization expert for system bottlenecks

### Orchestrator Agents
- **`project-manager`** - Expert project manager coordinating large-scale engineering projects
- **`github-issue-manager`** - Expert GitHub issue orchestrator for task and investigation management
- **`tech-lead-orchestrator`** - Senior technical lead providing strategic implementation recommendations
- **`project-analyst`** - Expert team member understanding project architecture and patterns

### Database Specialists
- **`database-reviewer`** - Validates schema changes, ensures database best practices
- **`postgres-expert`** - Comprehensive PostgreSQL database expert with performance optimization

### Language & Framework Specialists
- **`python-developer`** - Comprehensive Python developer across multiple frameworks
- **`typescript-backend-expert`** - TypeScript backend developer with Node.js expertise
- **`react-component-architect`** - Expert React architect specializing in modern patterns
- **`react-state-manager`** - Expert in React state management solutions
- **`react-nextjs-expert`** - Expert in Next.js framework with SSR/SSG capabilities

### Specialized Experts
- **`tailwind-css-expert`** - Expert frontend developer specializing in Tailwind CSS
- **`seo-optimizer`** - Expert in search engine optimization and organic traffic
- **`chief-of-staff`** - Expert in DevOps metrics and engineering analytics

## Development Workflow Patterns

### Install the agents
```
cd ~/.claude
cp -Rf agents ~/.claude/
cp -Rf hooks ~/.claude/
```

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
```
Create the high level plan of the feature I have no users, the product and platform are in full stealth. You now have access to the code and are the only developer.  Documentation should be documented in ./docs/project/<github-issue-id>. Perform a deep technical analysis to determine what you would need to build and add to implement this feature. Create a detailed plan only, and use @agent-project-manager and @agent-github-issue-manager to document the entire project in GitHub.
```

### 2. Detailed Implementation Planning

**Create Phased Approach:**
```
@agent-project-manager Coordinate this plan using <link to github issue> as the strategy source of truth. Use ultrathink and sequential thinking to produce a complete multi phase plan with dependencies, risks, and acceptance criteria, do not over engineer. Claude Code is the sole developer, there are no humans or teams to work with or plan for.  All timing and projects should be based on Claude developing the feature.  Coordinate with agents to explore, analyze, research, and propose actions. Update GitHub issues via @agent-github-issue-manager using the GitHub CLI. We are not in a hurry, take the time needed to design the best solution, do not optimize for simple or to get it done. Do not execute any changes until all planning phases are completed and reviewed. Prioritize quality, clear structure, and maintainability.
```

### 3. Implementation Execution

**Begin Implementation:**
```
@agent-project-manager Begin implementation with the agent team. Ensure each agent uses ultrathink and sequential thinking to perform their tasks. Do not advance to the next phase until the current phase's code is implemented, reviewed, optimized, and verified with code reviews. Update the tracking issue with progress via @agent-github-issue-manager. Enforce PR reviews and checklist sign off before any phase transition.
```

**Continue Each Phase:**
```
@agent-project-manager continue with the project and update the github issues with progress. Have the agents continue implementation.
```

### 4. Code Review & Quality Assurance

**Perform QA and bug remediation**

```
@agent-project-manager we now need to work on QA and bugs.  For all of the remaining prompts until I saw otherwise we will be fixing bugs from the optimization. Use ultrathink and the context of the github issues to investigate and remediate with our agents.
```

**Create a feature review branch off your feature branch**
This ensures all changes can be review in isolation and can be thrown away if things go sideways

**Comprehensive PR Review:**
```
PR Review - after a feature is done and before PR is merged
@agent-project-manager Coordinate a full code review of this PR. Use @agent-code-reviewer and @agent-github-issue-manager to create and update an issue with all findings, opportunities, and problems. This PR or branch could have redundant, over-engineered, verbose code that likely needs unification, refactored for re-usability, or cleaned up. Do not delete empty database tables, but check to make sure all database migrations are completed. Create a systematic plan using ultrathink and sequential thinking to identify key refactoring areas aligned with modern best practices. Use context7 MCP to reference all code documentation. This PR may have many side paths and duplicate workflows, so ensure a thorough and organized review.
```

### 5. Organize Commits and Issues
```
Commit, create branch, open PR and link all issues. @agent-project-manager @agent-github-issue-manager update all issues with completion status.  Commit all changes, push to branch and open PR and link PR to issues
```

## Key Features

### Memory & Context Management
- **Persistent Memory**: All agents leverage MCP Memory for maintaining context across sessions
- **Sequential Thinking**: Complex tasks use structured sequential thinking for systematic analysis
- **Ultrathink Integration**: Deep analysis capabilities for multi-step problem solving

### Agent Coordination
- **Orchestrated Workflows**: Project managers coordinate multiple specialists
- **Issue Tracking**: Automated GitHub issue creation and management
- **Quality Gates**: Enforced code review and testing requirements between phases

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
@agent-project-manager Coordinate with @agent-code-reviewer and @agent-github-issue-manager to [task]
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
model: claude-opus-4-1-20250805
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
1. **Start with orchestrators** (`project-manager`, `github-issue-manager`) for complex projects
2. **Use specialists** for language/framework-specific tasks
3. **Leverage reviewers** before finalizing implementations
4. **Coordinate through project managers** for multi-phase work

### Quality Assurance
- All phases require code review before advancement
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

