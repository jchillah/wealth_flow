# Workflow – How We Work

This project follows professional GitHub flow. Every code change is traceable back to a ticket.

## Sprint Process

1. Pick the top issue from the **To Do** column of the [project board](https://github.com/users/jchillah/projects/47)
2. Create a branch: `feature/<issue-number>-<short-slug>` (e.g. `feature/3-transactions-bloc`)
3. Commit using **Conventional Commits**: `feat:`, `fix:`, `refactor:`, `test:`, `docs:`, `chore:`
4. Open a pull request; the description contains `Closes #<issue-number>` → merging auto-closes the issue
5. Move the board card: To Do → In Progress → In Review → Done

## Definition of Done

- [ ] `flutter analyze` reports no issues
- [ ] `flutter test` is green
- [ ] No `print()` in production code – use `logger`
- [ ] Code reviewed (self-review counts, external review is better)
- [ ] Issue closed, card in **Done**

## Sprints & Milestones

2-week sprints; each milestone is one sprint's deliverable. See [milestones](https://github.com/jchillah/wealth_flow/milestones).
