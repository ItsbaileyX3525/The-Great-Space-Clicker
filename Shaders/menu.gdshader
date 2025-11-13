shader_type canvas_item;
// Hash function to create pseudo-randomness
float hash(vec2 p) {
	return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

// Improved hash for 2D vectors
vec2 hash2(vec2 p) {
	p = vec2(dot(p, vec2(127.1, 311.7)), dot(p, vec2(269.5, 183.3)));
	return fract(sin(p) * 43758.5453123);
}

// Perlin-style gradient noise for smooth transitions
float noise(vec2 p) {
	vec2 i = floor(p);
	vec2 f = fract(p);
	
	// Generate random gradients for corners
	vec2 ga = hash2(i) * 2.0 - 1.0;
	vec2 gb = hash2(i + vec2(1.0, 0.0)) * 2.0 - 1.0;
	vec2 gc = hash2(i + vec2(0.0, 1.0)) * 2.0 - 1.0;
	vec2 gd = hash2(i + vec2(1.0, 1.0)) * 2.0 - 1.0;
	
	// Compute dot products with distance vectors
	float va = dot(ga, f);
	float vb = dot(gb, f - vec2(1.0, 0.0));
	float vc = dot(gc, f - vec2(0.0, 1.0));
	float vd = dot(gd, f - vec2(1.0, 1.0));
	
	// Smooth interpolation (quintic hermite)
	vec2 u = f * f * f * (f * (f * 6.0 - 15.0) + 10.0);
	
	// Bilinear interpolation - normalize to 0-1 range
	float result = mix(mix(va, vb, u.x), mix(vc, vd, u.x), u.y);
	return clamp(result * 0.5 + 0.5, 0.0, 1.0);
}
void fragment() {
	vec2 uv = UV * 3.0; // scale UV space up for more stars
	// Layer multiple noise octaves for smoother nebula
	float nebula = noise(uv * 2.5 + TIME * 0.03);
	nebula += noise(uv * 1.2 + TIME * 0.02) * 0.5;
	nebula += noise(uv * 5.0 + TIME * 0.04) * 0.25;
	nebula /= 1.75; // normalize
	nebula = pow(nebula, 4.0); // emphasise bright bits but less aggressively

	// Add purple nebula clouds with different scale and movement
	float purple_cloud = noise(uv * 1.8 + TIME * 0.025);
	purple_cloud += noise(uv * 3.5 - TIME * 0.015) * 0.6;
	purple_cloud /= 1.6;

	// Create base background with original nebula
	vec3 bg_col = mix(vec3(0.0), vec3(0.1, 0.0, 0.15), nebula);
	bg_col += vec3(0.02, 0.0, 0.03); // add a subtle base purple glow

	// Add very subtle purple splashes with soft blending
	vec3 purple_splash = vec3(0.08, 0.03, 0.12) * purple_cloud * 0.5;
	bg_col += purple_splash;

	bg_col *= 0.6; // mostly dark but with purple undertone
	//--------------------------------
	// STARS (with slow horizontal drift to the left)
	//--------------------------------
	// Add time-based offset for very slow leftward movement
	vec2 star_offset = vec2(-TIME * 0.001, 0.0); // very slow drift
	vec2 star_uv = uv + star_offset;

	float total_star_brightness = 0.0;
	vec3 total_star_color = vec3(0.0);

	// Grid resolution for stars
	vec2 star_grid_uv = star_uv * 80.0;
	
	// Check 3x3 grid of cells to prevent clipping at edges
	for (int x = -1; x <= 1; x++) {
		for (int y = -1; y <= 1; y++) {
			vec2 neighbor_offset = vec2(float(x), float(y));
			vec2 star_grid = floor(star_grid_uv) + neighbor_offset;
			
			float rnd = hash(star_grid);
			float has_star = step(0.996, rnd);  // ~0.4% chance of star per cell

			// Randomize star position within its cell
			vec2 star_pos = star_grid + vec2(hash(star_grid + 2.7), hash(star_grid + 5.4));
			
			// Calculate distance from current pixel to star
			float dist = length(star_grid_uv - star_pos);

			// Star size with variation
			float size = 0.1 + hash(star_grid + 1.23) * 0.02;
			
			// Smooth circular falloff with soft edges
			float core = smoothstep(size * 2.0, 0.0, dist);
			core *= has_star;

			// Very subtle twinkle animation - only some stars twinkle very gently
			float twinkle_chance = hash(star_grid + 7.5);
			float twinkle = 1.0;
			if (twinkle_chance > 0.9) {  // Only 10% of stars twinkle
				// Extremely subtle twinkle - stays between 0.92 and 1.0 brightness
				twinkle = 0.92 + 0.08 * sin(TIME * (0.3 + hash(star_grid + 9.0) * 0.5) + rnd * 6.2831);
			}
			core *= twinkle;

			// Slight colour variation (blue-white to yellow-white)
			vec3 star_color = mix(vec3(0.8, 0.85, 1.0), vec3(1.0, 0.9, 0.7), hash(star_grid + 4.0));

			total_star_brightness += core;
			total_star_color += star_color * core;
		}
	}

	// Normalize and add to background
	if (total_star_brightness > 0.0) {
		total_star_color /= total_star_brightness;
		bg_col += total_star_color * total_star_brightness * 1.5;
	}
	COLOR = vec4(bg_col, 1.0);
}