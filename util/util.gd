class_name Util

static func free_children(node: Node) -> void:
	if not node: return
	for c in node.get_children():
		c.queue_free()
