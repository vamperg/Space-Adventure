shader_type spatial;

uniform vec3 sky_top_color = vec3(0.0, 0.2, 0.5);
uniform vec3 sky_bottom_color = vec3(0.0, 0.0, 0.1);

void vertex() {
    // Вычисляем позицию вершины в мировом пространстве
    VERTEX = (WORLD_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
    // Вычисляем направление нашей камеры в мировом пространстве
    vec3 camera_direction = normalize((WORLD_MATRIX * vec4(0.0, 0.0, 1.0, 0.0)).xyz);

    // Вычисляем угол между направлением и осью Y
    float cos_theta = dot(camera_direction, vec3(0.0, 1.0, 0.0));
    cos_theta = clamp(cos_theta, -1.0, 1.0);

    // Вычисляем коэффициент t от 0 до 1, который будет использоваться для смешивания двух цветов неба
    float t = acos(cos_theta) / PI;

    // Смешиваем два цвета неба в зависимости от коэффициента t
    vec3 color = mix(sky_bottom_color, sky_top_color, t * t);

    // Применяем коррекцию гаммы к цвету
    ALBEDO = pow(color, vec3(2.2));
}
