// Crie um Material de Shader para sua Label/TextMesh
shader_type canvas_item;

uniform sampler2D texture_albedo : source_color;

void fragment() {
    vec4 tex_color = texture(texture_albedo, UV);
    COLOR = tex_color;
}