precision mediump float;

uniform vec3 uLightDirection;
uniform vec3 uCameraPosition;
uniform sampler2D uTexture;

varying vec2 vTexcoords;
varying vec3 vWorldNormal;
varying vec3 vWorldPosition;

void main(void) {
    // todo - diffuse contribution
    // 1. normalize the light direction and store in a separate variable
    // 2. normalize the world normal and store in a separate variable
    // 3. calculate the lambert term

    vec3 normLightDirection = normalize(uLightDirection);
    vec3 normWorld = normalize(vWorldNormal);
    
    float lambert = dot(normLightDirection, normWorld);
    
    // todo - specular contribution
    // 1. in world space, calculate the direction from the surface point to the eye (normalized)
    // 2. in world space, calculate the reflection vector (normalized)
    // 3. calculate the phong term

    vec3 eyeVector = normalize(uCameraPosition - vWorldPosition);
    vec3 reflection = normalize(2.0 * lambert * (normWorld) - normLightDirection);
    
    float s = pow(dot(reflection, eyeVector), 64.0); 

    vec3 albedo = texture2D(uTexture, vTexcoords).rgb;

    // todo - combine
    // 1. apply light and material interaction for diffuse value by using the texture color as the material
    // 2. apply light and material interaction for phong, assume phong material color is (0.3, 0.3, 0.3)

    vec3 ambient = albedo * 0.3;
    vec3 diffuseColor = albedo * max(lambert, 0.0);
    vec3 specularColor = ambient * pow(max(dot(reflection, eyeVector), 0.0), 64.0);
    vec3 finalColor = ambient + diffuseColor + specularColor;

    //Input();

    gl_FragColor = vec4(finalColor, 1.0);
}
