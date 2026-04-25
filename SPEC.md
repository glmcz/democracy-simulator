# Democracy Simulator — Card Game App

## §G Goal

Playable card game where user leads town (mayor). Each card: question + picture + 2-4 answer choices. Thermometer top-left tracks "human orientation" (0-100). Story chains link cards. Designer-friendly data format — add cards/stories/text without code changes.

## §C Constraints

- All cards same layout (question, image, choices)
- Card choices → thermometer shift + next card selection
- Multiple branching story chains possible
- Web + mobile support (Flutter)
- Thermometer reflects cumulative choice history
- Design mode: toggle to edit story chains, add cards, modify choices + branching
- Design mode saves changes back to data files (sync with source)

## §I External Surfaces

- Card data format (struct: question, image, choices, thermometer delta, next_card_id)
- Story chain definition (entry card, card graph)
- Thermometer state (tracks 0-100, visible top-left, persists across cards)
- Choice routing (choice → delta + next_card_id branching)

## §V Invariants

V1. Card structure immutable. Every card has: `id`, `question`, `image_path`, `choices[]`, `next_card_ids[]`. No missing fields.

V2. Thermometer accumulates. Each choice applies delta (`+5`, `-3`, `0`). Final value clamped [0, 100]. Never resets mid-story.

V3. Story chains deterministic. Given card + choice, next card always same. No randomness.

V4. Designer data external. Card definitions live in data files (not hardcoded screens). App engine loads + renders generically.

V5. Choice count enforced. Every card has 2-4 choices (UI prevents invalid states).

V6. Design mode isolated. Toggle switches between play mode (story execution) and design mode (card graph editor). State not shared.

## §I External Surfaces

- Card data source (JSON/YAML/Dart file)
- Story chain definition (start card, branching graph)
- Thermometer component (displays 0-100, responsive to choices)
- Card renderer (generic widget for any card data)
- Design mode toggle (button/menu to switch play ↔ design)
- Card graph editor (visual or form-based card/choice editing)
- Persistence (write edited cards back to data files)

## §T Tasks

| id | status | title | cites |
|----|--------|-------|-------|
| T1 | `x` | Design card data struct + story chain format | V1,V3,V4 |
| T2 | `.` | Build Card widget (question, image, choice buttons layout) | V1,V5 |
| T3 | `.` | Build Thermometer widget (display 0-100, visual bar) | V2 |
| T4 | `.` | Implement story engine (load story, navigate by choice) | V3,V4 |
| T5 | `.` | Create example story chain (5-10 cards) | T1,T4 |
| T6 | `.` | Test choice routing (verify next_card_id logic) | V3 |
| T7 | `.` | Test thermometer accumulation (verify delta stacking) | V2 |
| T8 | `.` | Build design mode toggle (button to switch play ↔ design) | V6 |
| T9 | `.` | Build card editor UI (form: question, image, choices, deltas) | V1,V5 |
| T10 | `.` | Build story chain graph editor (add cards, link choices) | V1,V3 |
| T11 | `.` | Implement file persistence (save edited cards to data source) | V4,V6 |
| T12 | `.` | Test design mode: create new story chain end-to-end | T8,T10,T11 |

## §B Bug Log

| id | date | cause | fix |
|----|------|-------|-----|
