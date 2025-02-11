#version 450 core

layout (location = 0) in vec3 vPosition;
layout (location = 4) in uvec2 vSkin;

layout (location = 0) uniform mat4 MVP;
layout (location = 3) uniform int bone_count;
layout (location = 4) uniform vec3 geoset_color;
layout (location = 5) uniform float layer_alpha;
layout (location = 8) uniform mat4 bones[217]; // Thats a lotta boners. max 200 because the shader compiler issues an error when going higher

void main() {
	const mat4 b0 = bones[int(vSkin.x & 0x000000FF)];
	const mat4 b1 = bones[int(vSkin.x & 0x0000FF00) >> 8];
	const mat4 b2 = bones[int(vSkin.x & 0x00FF0000) >> 16];
	const mat4 b3 = bones[int(vSkin.x & 0xFF000000) >> 24];
	const float w0 = (vSkin.y & 0x000000FF) / 255.f;
	const float w1 = ((vSkin.y & 0x0000FF00) >> 8) / 255.f;
	const float w2 = ((vSkin.y & 0x00FF0000) >> 16) / 255.f;
	const float w3 = ((vSkin.y & 0xFF000000) >> 24) / 255.f;
	
	vec4 position = vec4(vPosition, 1.f);
	position = b0 * position * w0 + b1 * position * w1 + b2 * position * w2 + b3 * position * w3;
	position.w = 1.f;

	gl_Position = MVP * position;
	
	vec4 vertexColor = vec4(geoset_color, layer_alpha);
}