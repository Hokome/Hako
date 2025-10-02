extends Control
class_name AdvancedTooltip

## Prototype values can be used with {}, functions will work too
## Keywords can be referenced with '#'.
## Prototypes can be referenced with '@'
## Keywords and prototypes can be dynamic like so "#{attribute}"
## Common things that do not require tooltips can be pasted with '$'
## All of these can be escaped
func parse(text: String, prototype: Prototype, instance: Node) -> void:
	pass
