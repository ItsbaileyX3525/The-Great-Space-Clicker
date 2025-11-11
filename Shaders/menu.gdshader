shader_type canvas_item;

// Hash function to create pseudo-randomness
float hash(vec2 p) {
	return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

// Noise-like function for soft background texture
float noise(vec2 p) {
	vec2 i = floor(p);
	vec2 f = fract(p);

	float a = hash(i);
	float b = hash(i + vec2(1.0, 0.0));
	float c = hash(i + vec2(0.0, 1.0));
	float d = hash(i + vec2(1.0, 1.0));

	vec2 u = f * f * (3.0 - 2.0 * f); // smooth curve
	return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

void fragment() {
	vec2 uv = UV * 2.0; // scale UV space up for more stars

	// Layer multiple noise octaves for smoother nebula
	float nebula = noise(uv * 2.5 + TIME * 0.03);
	nebula += noise(uv * 1.2 + TIME * 0.02) * 0.5;
	nebula += noise(uv * 5.0 + TIME * 0.04) * 0.25;
	nebula /= 1.75; // normalize
	
	nebula = pow(nebula, 4.0); // emphasise bright bits but less aggressively
	vec3 bg_col = mix(vec3(0.0), vec3(0.1, 0.0, 0.15), nebula);
	bg_col += vec3(0.02, 0.0, 0.03); // add a subtle base purple glow to eliminate black areas
	bg_col *= 0.5; // mostly dark but with purple undertone

	//--------------------------------
	// STARS
	//--------------------------------
	vec2 star_grid = floor(uv * 80.0);  // density of stars
	vec2 local = fract(uv * 80.0);      // position within the cell

	float rnd = hash(star_grid);
	float has_star = step(0.996, rnd);  // ~0.4% chance of star per cell
	
	// Star parameters
	float size = 0.25 + hash(star_grid + 1.23) * 0.6;
	vec2 centre = vec2(hash(star_grid + 2.7), hash(star_grid + 5.4));
	float dist = length(local - centre);

	// Smooth circular falloff with soft edges
	float core = smoothstep(size + 0.1, 0.0, dist);
	core *= has_star;

	// Twinkle animation using a unique random phase
	float twinkle = 0.5 + 0.5 * sin(TIME * (2.0 + hash(star_grid + 9.0) * 5.0) + rnd * 6.2831);
	core *= 0.7 + 0.3 * twinkle;

	// Slight colour variation (blue-white to yellow-white)
	vec3 star_color = mix(vec3(0.8, 0.85, 1.0), vec3(1.0, 0.9, 0.7), hash(star_grid + 4.0));

	bg_col += star_color * core * 1.5;

	COLOR = vec4(bg_col, 1.0);
}
