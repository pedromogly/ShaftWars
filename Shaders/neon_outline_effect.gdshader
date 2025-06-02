shader_type canvas_item;

// Configurações do neon
uniform vec4 trail_color : source_color = vec4(0.0, 0.8, 1.0, 0.8); // Cor do rastro
uniform float trail_length : hint_range(0.0, 1.0) = 0.3; // Comprimento do rastro
uniform int trail_samples : hint_range(1, 20) = 8; // Qualidade do rastro
uniform float glow_intensity : hint_range(1.0, 10.0) = 3.0; // Intensidade do brilho

// Efeito de pulsação
uniform float pulse_speed : hint_range(0.0, 5.0) = 1.0;
uniform float pulse_strength : hint_range(0.0, 1.0) = 0.3;

// Direção do movimento (deve ser definida via script)
uniform vec2 move_direction = vec2(1.0, 0.0); // Padrão: direita

void fragment() {
    // Cor original do sprite
    vec4 tex_color = texture(TEXTURE, UV);

    // Normaliza a direção do movimento
    vec2 dir = normalize(move_direction);

    // Efeito de pulsação
    float pulse = 1.0 + sin(TIME * pulse_speed) * pulse_strength;

    // Cria o rastro
    vec4 trail = vec4(0.0);
    for (int i = 0; i < trail_samples; i++) {
        float t = float(i) / float(trail_samples);
        vec2 trail_uv = UV - dir * t * trail_length;

        // Suaviza a extremidade do rastro
        float alpha = smoothstep(0.0, 0.2, 1.0 - t);

        vec4 sample = texture(TEXTURE, trail_uv);
        trail += sample * alpha * (1.0 - t);
    }
    trail /= float(trail_samples);

    // Combina o rastro com a cor original
    COLOR = mix(tex_color, trail_color, trail.a);
    COLOR.rgb *= glow_intensity * pulse;
    COLOR.a = max(tex_color.a, trail.a);
}