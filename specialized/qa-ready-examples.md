# QA-Ready Agent Example Scenarios

## Example 1: Bug Report Analysis

### Input Ticket:
```
Title: Login button not working
Description: Users can't login
Steps: Click login button
```

### QA-Ready Agent Output:

**QA Readiness Score: 25/100**
**Recommendation: Not Ready**
**Critical Gaps:**
1. No reproduction steps
2. Missing environment details
3. No error information

**Recommended Rewrite:**
```
Title: [Auth] - Login button unresponsive on Chrome/Safari after entering valid credentials

Environment:
- Browser: Chrome 120.0, Safari 17.1
- OS: macOS 14.0
- Environment: Production
- User Role: Standard user

Steps to Reproduce:
1. Navigate to https://app.example.com/login
2. Enter valid email: test@example.com
3. Enter valid password: [correct password]
4. Click "Login" button
5. Observe: Button shows loading state but never completes

Expected: User redirected to dashboard
Actual: Infinite loading state, no error message

Frequency: Always reproducible (100%)
Severity: Critical - Users cannot access application
```

---

## Example 2: Feature Request Analysis

### Input Ticket:
```
Title: Add dark mode
User Story: As a user, I want dark mode for better viewing at night
```

### QA-Ready Agent Output:

**QA Readiness Score: 45/100**
**Recommendation: Needs Work**

**Enhanced User Story:**
```
As a user who works in low-light environments
I want to toggle between light and dark themes
So that I can reduce eye strain and improve readability

Acceptance Criteria:
1. Given user is on any page, When they click theme toggle, Then UI switches to dark/light mode
2. Given user selects a theme, When they refresh page, Then preference persists
3. Given user is in dark mode, When viewing charts/graphs, Then colors maintain accessibility contrast (WCAG AA)
4. Given system is in dark mode, When printing, Then output uses light theme
5. Performance: Theme switch completes in <100ms

Test Scenarios:
- Verify theme toggle appears in header navigation
- Test persistence across sessions using localStorage
- Validate all color combinations meet WCAG 2.1 AA standards
- Test theme inheritance in modals and popups
- Verify images/logos swap for theme-appropriate versions
- Test keyboard navigation visibility in both themes
```

---

## Example 3: Technical Task Analysis

### Input Ticket:
```
Title: Migrate database to PostgreSQL 15
Description: Upgrade database from PostgreSQL 12 to 15
```

### QA-Ready Agent Output:

**QA Readiness Score: 35/100**
**Recommendation: Needs Work**

**Critical Missing Elements:**
1. No rollback strategy defined
2. Missing data validation approach
3. No performance benchmarks
4. Zero downtime strategy not specified

**Required Test Plan:**
```
Pre-Migration Testing:
1. Backup verification test
2. Migration script dry-run in staging
3. Performance baseline capture (current query times)
4. Data integrity checksums

Migration Testing:
1. Schema compatibility validation
2. Index migration verification
3. Stored procedure/function testing
4. Permission/role migration validation
5. Connection pool behavior testing

Post-Migration Testing:
1. Data integrity validation (row counts, checksums)
2. Performance regression testing (compare to baseline)
3. Application integration testing
4. Backup/restore process validation
5. Monitoring and alerting verification

Rollback Testing:
1. Rollback procedure execution (<5 minutes)
2. Data consistency after rollback
3. Application functionality post-rollback
```

---

## Example 4: High-Quality Ticket (Scores 90+)

### Input Ticket:
```
Title: [Payments] - Implement Stripe webhook for subscription renewals

User Story:
As a SaaS platform
I want to automatically process Stripe subscription renewal webhooks
So that user access is maintained without manual intervention

Acceptance Criteria:
1. Given Stripe sends renewal webhook, When signature is valid, Then update user subscription status
2. Given webhook processing fails, When retry attempted, Then use exponential backoff (max 3 retries)
3. Given renewal fails, When payment_failed event received, Then send notification email to user
4. Performance: Webhook processing completes in <500ms
5. Security: All webhooks validated using Stripe signature verification

Technical Details:
- Endpoint: POST /api/webhooks/stripe
- Webhook events: customer.subscription.updated, invoice.payment_succeeded, invoice.payment_failed
- Idempotency: Use Stripe event ID to prevent duplicate processing
- Database: Update subscriptions table with new period_end date

Test Scenarios Included:
- Successful renewal processing
- Failed payment handling
- Duplicate webhook prevention
- Signature validation failure
- Database transaction rollback on error
```

### QA-Ready Agent Output:

**QA Readiness Score: 92/100**
**Recommendation: Ready with minor suggestions**

**Suggested Additions:**
1. Add rate limiting test case (webhook bombardment)
2. Include test for webhook timeout scenarios
3. Add monitoring alert configuration for webhook failures
4. Specify test data setup for different subscription tiers

**High-Priority Test Cases:**
1. **Webhook Signature Validation**
   - Given: Invalid signature
   - When: Webhook received
   - Then: Return 401, log security event
   - Priority: P0
   - Automation: Yes

2. **Idempotency Check**
   - Given: Duplicate Stripe event ID
   - When: Webhook redelivered
   - Then: Return 200 without reprocessing
   - Priority: P0
   - Automation: Yes

---

## Usage Examples

### Example Command 1: GitHub Issue Review
```
User: Review GitHub issue #456 for QA readiness
Assistant: I'll use the qa-ready agent to analyze this issue...

[Agent analyzes issue and returns structured QA assessment]
```

### Example Command 2: Jira Ticket Enhancement
```
User: Can you check if PROJ-789 is ready for QA and suggest improvements?
Assistant: Let me use the qa-ready agent to evaluate the ticket's test requirements...

[Agent provides QA score, missing elements, and rewritten sections]
```

### Example Command 3: Batch Ticket Review
```
User: Review these three bug reports for QA completeness: BUG-101, BUG-102, BUG-103
Assistant: I'll use the qa-ready agent to assess each ticket's QA readiness...

[Agent analyzes each ticket and provides consolidated recommendations]
```