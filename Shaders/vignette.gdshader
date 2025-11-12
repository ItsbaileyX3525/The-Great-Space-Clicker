shader_type canvas_item;

uniform float vignette_strength : hint_range(0.0, 2.0) = 0.8;
uniform float vignette_radius : hint_range(0.1, 3.0) = 1.0;
uniform vec4 vignette_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

void fragment() {
	// SCREEN_UV is 0..1 across the viewport
	vec2 uv = SCREEN_UV - vec2(0.5);

	// distance from centre
	float dist = length(uv) * vignette_radius;

	// inner/outer falloff controls; tune for subtlety
	float falloff_inner = 0.35;
	float falloff_outer = 0.9;
	float vign = smoothstep(falloff_inner, falloff_outer, dist);

	// compute alpha and output
	float alpha = clamp(vign * vignette_strength * vignette_color.a, 0.0, 1.0);
	COLOR = vec4(vignette_color.rgb, alpha);
}
