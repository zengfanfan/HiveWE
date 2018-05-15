#pragma once

class Shapes {
public:
	void init();

	GLuint vertex_buffer;
	GLuint index_buffer;

	const std::vector<glm::vec2> quad_vertices = {
		{ 1, 1 },
		{ 0, 1 },
		{ 0, 0 },
		{ 1, 0 }
	};

	const std::vector<glm::uvec3> quad_indices = {
		{ 0, 3, 1 },
		{ 1, 3, 2 }
	};
};

// String functions
std::vector<std::string> split(const std::string& string, char delimiter);
bool is_number(const std::string& s);

GLuint compile_shader(const fs::path& vertex_shader, const fs::path& fragment_shader);

std::string read_text_file(const std::string& path);

fs::path find_warcraft_directory();

void load_modification_table(BinaryReader& reader, slk::SLK& base_data, slk::SLK& meta_data, bool modification, bool optional_ints = false);

// Convert a Texture into an QIcon with two states
QIcon texture_to_icon(uint8_t* data, int width, int height);

extern QOpenGLFunctions_4_5_Core* gl;
extern Shapes shapes;