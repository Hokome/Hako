## Random number generator utility. Most functions take a
## [RandomNumberGenerator] as an optional argument.
class_name RNG

static var _default_rng := RandomNumberGenerator.new()

## Even distribution within a circle of designated [param radius]
static func even_circle(radius: float, rng: RandomNumberGenerator = null) -> Vector2:
	if not rng: rng = _default_rng
	return Vector2.ZERO

## Returns the integer part of [param chance] plus a chance at one more by
## using the decimal part as probability
static func overflow_roll(chance: float, rng: RandomNumberGenerator = null) -> int:
	if not rng: rng = _default_rng
	return 0
