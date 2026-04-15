# Task Packets

Task packets are the execution units for this project and the default immediate-use
work surface for P3.

## Rules

- Each task packet home contains a primary `TASK-*.md` file and sibling `packet.yaml`.
- Inputs, outputs, working materials, and evidence remain nested inside the task packet home.
- Status, priority, assignee, validation status, and parent references should be
  maintained in `packet.yaml`.
- Live packets should follow the lifecycle `draft -> ready -> active -> blocked |
  in-review -> done | returned`.
- Pickup means moving `status` to `active` and filling `active_assignee`.
- Review means `outputs/` contains the result and `evidence/` contains the proof.
- Closeout means the packet is updated to `done`, the validation result is
  recorded, and the work remains in the packet home as durable history.
