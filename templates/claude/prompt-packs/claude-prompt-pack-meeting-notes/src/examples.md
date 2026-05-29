# Examples — Meeting Notes Summarizer

## Example: Sprint Planning (using sample-meeting.txt fixture)

**Input:** Contents of `src/fixtures/sample-meeting.txt`

**Expected Claude output:**

```markdown
## Meeting Summary
**Date:** May 29, 2026
**Duration:** not specified
**Participants:** Ana (PM), Carlos (Backend), Maria (Frontend), Luis (DevOps)
**Meeting type:** Planning

## Executive Summary
The team conducted sprint planning for the current cycle, reviewing last sprint's outcomes (auth refactor shipped, rate limiting pending) and aligning on deliverables for a client demo on June 10. All sprint items must be deployed by June 8.

## Key Decisions
- Dashboard redesign mockups approved by Ana — Maria will begin implementation Monday
- Client demo scheduled for June 10; hard deployment deadline is June 8
- Rate limiter feature: June 5 deadline confirmed

## Action Items
| Action | Owner | Due Date | Priority |
|--------|-------|----------|----------|
| Complete rate limiter implementation | Carlos | June 5 | High |
| Provision Redis instance for rate limiting | Luis | Today (May 29) | High |
| Write regression test for mobile login timeout bug | Carlos | End of week (May 31) | Medium |
| Start dashboard implementation | Maria | Monday (June 2) | High |
| Update deployment pipeline for Redis dependency | Luis | This week | High |
| Research Redis Cluster vs single node (cost analysis) | Luis | Friday (May 31) | Medium |

## Open Questions / Follow-up
- Redis architecture decision: Cluster vs single node? Luis to report back by Friday.

## Next Meeting
Sprint Planning — June 12, 10:00am
```
