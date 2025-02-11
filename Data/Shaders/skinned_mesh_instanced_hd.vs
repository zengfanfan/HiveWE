#version 450 core

layout (location = 0) in vec3 vPosition;
layout (location = 1) in vec2 vUV;
layout (location = 2) in vec3 vNormal;
layout (location = 3) in vec4 vTangent;
layout (location = 4) in uvec2 vSkin;
layout (location = 5) in mat4 vInstance;

layout (location = 0) uniform mat4 VP;
layout (location = 3) uniform int bone_count;
layout (location = 4) uniform int layer_skip_count;
layout (location = 5) uniform int layer_index;
layout (location = 6) uniform vec3 light_direction;

layout(std430, binding = 0) buffer layoutName {
    vec4 layer_colors[];
};

layout (binding = 5) uniform samplerBuffer nodeMatrices;

out vec2 UV;
out vec3 tangent_light_direction;
out vec4 vertexColor;

mat4 fetchMatrix(int bone_index) {
	return mat4(
		texelFetch(nodeMatrices, gl_InstanceID * bone_count * 4 + bone_index * 4),
		texelFetch(nodeMatrices, gl_InstanceID * bone_count * 4 + bone_index * 4 + 1),
		texelFetch(nodeMatrices, gl_InstanceID * bone_count * 4 + bone_index * 4 + 2),
		texelFetch(nodeMatrices, gl_InstanceID * bone_count * 4 + bone_index * 4 + 3));
}

void main() {
	const mat4 b0 = fetchMatrix(int(vSkin.x & 0x000000FF));
	const mat4 b1 = fetchMatrix(int(vSkin.x & 0x0000FF00) >> 8);
	const mat4 b2 = fetchMatrix(int(vSkin.x & 0x00FF0000) >> 16);
	const mat4 b3 = fetchMatrix(int(vSkin.x & 0xFF000000) >> 24);
	const float w0 = (vSkin.y & 0x000000FF) / 255.f;
	const float w1 = ((vSkin.y & 0x0000FF00) >> 8) / 255.f;
	const float w2 = ((vSkin.y & 0x00FF0000) >> 16) / 255.f;
	const float w3 = ((vSkin.y & 0xFF000000) >> 24) / 255.f;
	mat4 skinMatrix = vInstance * (b0 * w0 + b1 * w1 + b2 * w2 + b3 * w3);
	
	gl_Position = VP * skinMatrix * vec4(vPosition, 1.f);

	mat3 model = mat3(skinMatrix);
	vec3 T = normalize(model * vTangent.xyz);
	vec3 N = normalize(model * vNormal);
	vec3 B = cross(N, T) * vTangent.w; // to fix handedness
	mat3 TBN = transpose(mat3(T, B, N));

	UV = vUV;
	tangent_light_direction = normalize(TBN * light_direction);
	vertexColor = layer_colors[gl_InstanceID * layer_skip_count + layer_index];
}