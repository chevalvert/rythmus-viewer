public class Pillar {
  public int index;
  public int height;
  public int ledHeight;
  public float angle;
  public PVector position;

  public int[][] leds;

  private PShape SHAPE_pillar;
  private PShape SHAPE_leds;

  Pillar (int i, PVector position, int height, float angle) {
    this.index = i;
    this.position = position;
    this.height = height;
    this.angle = angle;

    this.createShapes();
    this.leds = new color[PILLAR_leds_length * 2][3];
    for (int[] l : this.leds) {
      l = new int[3];
      for (int a : l) a = 0;
    }
  }

  private void createShapes () {
    this.SHAPE_pillar = createShape(GROUP);

    PShape leds = cylinder(5, PILLAR_radius, this.height - PILLAR_height_offset, true);
    leds.translate(0, 0, PILLAR_height_offset / 2);
    leds.setFill(PILLAR_color);
    this.SHAPE_pillar.addChild(leds);

    PShape foot = cylinder(5, PILLAR_radius / 2, PILLAR_height_offset, true);
    foot.translate(0, 0, -(this.height - PILLAR_height_offset) / 2);
    foot.setFill(color(0));
    this.SHAPE_pillar.addChild(foot);

    this.SHAPE_pillar.setStroke(false);

    this.SHAPE_leds = createShape(GROUP);
    float ledHeight = (this.height - PILLAR_height_offset) / (float) PILLAR_leds_length;
    for (int ledMode = 0; ledMode < 2; ledMode++) {
      int angleOffset = ledMode * 180;
      for (int index = 0; index < PILLAR_leds_length; index++) {
        float y = ledMode == 0
          ? map(index, 0, PILLAR_leds_length, PILLAR_height_offset, this.height)
          : map(index, 0, PILLAR_leds_length, this.height, PILLAR_height_offset);
        PShape led = half_cylinder(10, PILLAR_radius + 1, ledHeight, false, PILLAR_face_aperture, angleOffset + PILLAR_face_aperture_offset);
        led.translate(0, 0, y + (ledHeight * 0.5) - (this.height * 0.5));
        this.SHAPE_leds.addChild(led);
      }
    }
    this.SHAPE_leds.setStroke(false);
  }

  public void draw () {
    pushMatrix();
    translate(this.position.x, this.position.y, this.height / 2);
    rotateZ(this.angle);
    shape(this.SHAPE_pillar);

    for (int z = 0; z < this.SHAPE_leds.getChildCount(); z++) {
      PShape led = this.SHAPE_leds.getChild(z);
      color rgb = color(this.leds[z][0], this.leds[z][1], this.leds[z][2]);
      led.setFill(rgb);
    }

    shape(this.SHAPE_leds);
    popMatrix();
  }
}
