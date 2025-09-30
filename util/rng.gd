## Random number generator utility. Most functions take a
## [RandomNumberGenerator] as an optional argument.
class_name RNG

static var _default_rng := RandomNumberGenerator.new()

## Even distribution within a circle of designated [param radius]
static func even_circle(radius: float, rng: RandomNumberGenerator = null) -> Vector2:
	if not rng: rng = _default_rng
	var sqr_radius := radius * radius
	var result := even_square(radius, rng)
	
	while result.length_squared() > sqr_radius:
		result = even_square(radius, rng)
	
	return Vector2.ZERO

static func even_square(radius: float, rng: RandomNumberGenerator = null) -> Vector2:
	if not rng: rng = _default_rng
	return Vector2(rng.randf_range(-radius, radius), rng.randf_range(-radius, radius))

## Returns the integer part of [param chance] plus a chance at one more by
## using the decimal part as probability
static func overflow_roll(chance: float, rng: RandomNumberGenerator = null) -> int:
	if not rng: rng = _default_rng
	var whole := floori(chance)
	return whole + coin_flip(fmod(chance, 1))

## Returns either 1 or 0 with a possible [param bias]
static func coin_flip(bias: float = 0.5, rng: RandomNumberGenerator = null) -> int:
	if not rng: rng = _default_rng
	var flip := rng.randf_range(0, 1)
	if flip >= bias:
		return 1
	else:
		return 0
