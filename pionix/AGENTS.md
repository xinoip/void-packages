# Instructions

- Never create commits, stage changes, or push to remote repositories.
  Exception: the requested automated commit in `scripts/bump-brave.sh` is
  allowed when the updater runs; it must include only the Brave template.
- Keep this personal repository simple. Write for the happy path; unusual
  failures and edge cases will be handled manually.
- Use tool defaults. Do not add declarations just to make defaults explicit. For
  example, omit `SHELL` from Makefiles unless a recipe needs a different shell,
  and put the intended default target first instead of setting `.DEFAULT_GOAL`.
- Prefer direct commands in Make recipes and short scripts. Do not introduce
  helper frameworks, dispatchers, abstractions, or extra configuration layers
  for straightforward tasks.
- Do not add defensive validation, dependency checks, fallback behavior,
  rollback logic, or cleanup machinery unless explicitly requested or needed for
  a demonstrated problem.
- Implement only the requested workflow. Do not add speculative features,
  options, targets, or generality for possible future use.
- Before adding code or configuration, ask whether removing it would break the
  requested happy path. If not, leave it out unless it clearly improves
  readability.
- Keep documentation and verification proportional to the change. Explain the
  commands needed to use the repository without exhaustively documenting
  hypothetical failures.
