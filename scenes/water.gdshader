shader_type spatial;
render_mode specular_toon;


uniform sampler2D noise;
uniform sampler2D normalmap;
uniform float height_scale = 0.05;

varying vec2 tex_position;


float wave(vec2 position) {
	position += texture(noise, position / 5.0).x * 2.0 - 1.0;
	vec2 wv = 1.0 - abs(sin(position)) * 0.9;
	return pow(1.0 - pow(wv.x * wv.y, 0.5), 10.0);
}

float height(vec2 position, float time) {
	time *= 0.3;
	float d = wave((position + time) * 0.4) * 0.3;
	d += wave((position - time) * 0.3) * 0.3;
	d += wave((position + time) * 0.5) * 0.2;
	d += wave((position - time) * 0.6) * 0.2;
	return d;
}

void vertex() {
	vec2 pos = VERTEX.xz;
	float k = height(pos, TIME);
	VERTEX.y = k * 0.3;
	NORMAL = normalize(vec3(k - height(pos + vec2(0.1, 0.0), TIME), 0.1, k - height(pos + vec2(0.0, 0.1), TIME)));
}

void fragment() {
	float fresnel = sqrt(1.0 - dot(NORMAL, VIEW));
	RIM = 0.2;
	METALLIC = 0.0;
	ROUGHNESS = 0.01 * (1.0 - fresnel);
	ALBEDO = vec3(0.1, 0.3, 0.5) + (0.1 * fresnel);
	NORMAL_MAP = texture(normalmap, tex_position).xyz;
}

void light() {
	// Called for every pixel for every light affecting the material.
}
