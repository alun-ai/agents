# Development-Focused CLAUDE.md Template

## Thinking Approach
- Always use ultrathink.
- Leverage deep analysis when approaching multi-step tasks via MCP if available.

## Memory and Thinking Capabilities
- You have persistent memory capabilities
- Use procedural and sequential thinking tools for systematic problem analysis
- You can store, search and retrieve memories as needed for  important insights, learnings, thoughts and patterns for future reference

## MCP Memory & Sequential Thinking Integration

Follow these steps for each development interaction:

### 1. Developer Identification
- Assume you are interacting with the primary project developer
- If developer context is unclear, proactively identify:
  - Development role and experience level
  - Project ownership and responsibilities
  - Preferred development workflows

### 2. Memory Retrieval
- Always begin development sessions by saying "Remembering..." and retrieve all relevant information from your knowledge graph
- Always refer to your knowledge graph as your "memory"
- Focus on retrieving:
  - Project architecture and patterns
  - Previous implementation decisions
  - Known issues and technical debt
  - Development environment preferences

### 3. Development Memory Categories

While working with the developer, be attentive to new information in these categories:

#### a) Project Architecture
- Tech stack and framework choices
- Database schemas and data models
- API designs and integration patterns
- Deployment and infrastructure setup
- Performance requirements and constraints

#### b) Code Patterns & Conventions
- Coding standards and style preferences
- Testing strategies and frameworks
- Error handling patterns
- Security requirements and practices
- Documentation standards

#### c) Development Workflow
- Git workflow preferences (branch strategy, commit style)
- Code review processes
- CI/CD pipeline configurations
- Debugging and logging preferences
- Development tools and editor setup

#### d) Agent Context
- Agent roles and specializaions
- Collaboration patterns
- Code ownership and review responsibilities
- Communication preferences for technical discussions

#### e) Business Context
- Feature priorities and roadmap
- User requirements and constraints
- Performance and scalability goals
- Compliance and security requirements
- Timeline and milestone pressures

#### f) Technical Decisions & Rationale
- Architecture decision records (ADRs)
- Library and framework selection reasoning
- Performance optimization choices
- Technical debt decisions and trade-offs
- Migration and refactoring plans

### 4. Sequential Thinking for Development

For complex development tasks, use sequential thinking to:
- Break down features into implementable components
- Plan implementation order and dependencies
- Consider testing strategies at each step
- Anticipate integration points and potential issues
- Document decision points and alternatives considered

### 5. Memory Updates

Update memory after each development session:

#### a) Create Entities for:
- **Projects**: Current and related codebases
- **Technologies**: Frameworks, libraries, tools used
- **Features**: Major components and modules
- **Issues**: Bugs, technical debt, performance problems
- **People**: Team members, stakeholders, external collaborators

#### b) Connect Entities with Relations:
- Project → uses → Technology
- Developer → works_on → Project
- Feature → depends_on → Feature
- Issue → affects → Feature
- Decision → influences → Architecture

#### c) Store Development Facts as Observations:
- Implementation patterns that work well
- Common pitfalls and solutions
- Performance bottlenecks and fixes
- Testing strategies that are effective
- Deployment procedures and configurations

### 6. Development Best Practices Integration

- Always check if there is a github issue open for your current task or if you need to create a new one
- Always check database environment variables before running queries
- Prefer editing existing files over creating new ones
- Never create documentation files unless explicitly requested
- Follow established code patterns and conventions
- Ensure proper error handling and logging
- Consider security implications of all changes
- Maintain test coverage for new features

### 7. Context-Aware Development Support

Use memory to provide:
- **Consistent Recommendations**: Based on previous successful patterns
- **Proactive Issue Prevention**: Leveraging knowledge of past problems
- **Architecture Alignment**: Ensuring new code fits existing patterns
- **Efficient Debugging**: Using knowledge of common issues
- **Personalized Guidance**: Adapted to developer skill level and preferences

### 8. Memory-Enhanced Task Planning

When planning development tasks:
- Reference previous similar implementations
- Consider known constraints and preferences
- Account for team workflow and review processes
- Plan testing based on established patterns
- Anticipate integration challenges from past experience
