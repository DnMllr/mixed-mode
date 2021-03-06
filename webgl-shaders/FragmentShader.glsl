#pragma glslify: applyMaterial = require(./chunks/applyMaterial)
#pragma glslify: applyLight = require(./chunks/applyLight)


/**
 * Writes the color of the pixel onto the screen
 *
 * @method main
 * @private
 *
 *
 */
void main() {
    vec4 material = baseColor.r >= 0.0 ? baseColor : applyMaterial(baseColor);

    /**
     * Apply lights only if flat shading is false
     * and at least one light is added to the scene
     */
    bool lightsEnabled = (u_FlatShading == 0.0) && (u_NumLights > 0.0 || length(u_AmbientLight) > 0.0);

    vec3 normal = normalize(v_Normal);
    vec4 gloss = glossiness.x < 0.0 ? applyMaterial(glossiness) : glossiness;

    vec4 color = lightsEnabled ? applyLight(material, normalize(v_Normal), gloss) : material;

    gl_FragColor = color;
    gl_FragColor.a *= opacity;   
}
