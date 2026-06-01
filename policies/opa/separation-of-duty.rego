package sovereignpublishing.separation_of_duty

# Separation of Duty policy for publishing gates.
# Denies workflows where the same actor performs conflicting duties.

import future.keywords.if
import future.keywords.in

default allow := false

conflicting_roles := {
  ["author", "reviewer"],
  ["author", "approver"],
  ["author", "publisher"],
  ["reviewer", "approver"],
  ["sponsor", "reviewer"],
  ["sponsor", "approver"],
  ["platform_operator", "editorial_approver"]
}

actor_for_role(role) := actor if {
  some assignment in input.assignments
  assignment.role == role
  actor := assignment.actor_id
}

violation[msg] if {
  some pair in conflicting_roles
  left := pair[0]
  right := pair[1]
  actor_for_role(left) == actor_for_role(right)
  msg := sprintf("separation of duty violation: actor %q cannot be both %q and %q", [actor_for_role(left), left, right])
}

violation[msg] if {
  input.gate in {"publish_approval", "registry_publish", "commerce_release"}
  not actor_for_role("approver")
  msg := "separation of duty violation: approver is required for this gate"
}

violation[msg] if {
  input.gate == "publish_approval"
  not actor_for_role("reviewer")
  msg := "separation of duty violation: reviewer is required before publish approval"
}

allow if {
  count(violation) == 0
}

decision := {
  "allow": allow,
  "violations": violation,
  "policy": "separation-of-duty",
  "policy_version": "0.1.0"
}
