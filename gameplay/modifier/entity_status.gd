extends Node
class_name EntityStatus

func apply(status: StatusEffect) -> void:
	var existing: StatusEffect = get_node_or_null(status.name as String)
	if existing:
		existing.merge(status)
	else:
		if status.is_inside_tree():
			status.reparent(self)
		else:
			add_child(status)
		status.apply(get_parent())

func cure(status_name: NodePath) -> void:
	var status: StatusEffect = get_node_or_null(status_name)
	status.cure(get_parent())
