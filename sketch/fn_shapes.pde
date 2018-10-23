PShape cylinder (int sides, float r, float h) { return cylinder(sides, r, h, false); }
PShape cylinder (int sides, float r, float h, boolean cap) {
  PShape cylinder = createShape(GROUP);

  float angle = 360 / sides;
  float halfHeight = h / 2;

  if (cap) {
    PShape top_cap = createShape();
    top_cap.beginShape();
    for (int i = 0; i < sides; i++) {
      float x = cos(radians(i * angle)) * r;
      float y = sin(radians(i * angle)) * r;
      top_cap.vertex(x, y, -halfHeight);
    }
    top_cap.endShape(CLOSE);

    PShape bottom_cap = createShape();
      // draw bottom of the tube
    bottom_cap.beginShape();
    for (int i = 0; i < sides; i++) {
      float x = cos(radians(i * angle)) * r;
      float y = sin(radians(i * angle)) * r;
      bottom_cap.vertex(x, y, halfHeight);
    }
    bottom_cap.endShape(CLOSE);

    cylinder.addChild(top_cap);
    cylinder.addChild(bottom_cap);
  }

    // draw sides
  PShape body = createShape();
  body.beginShape(TRIANGLE_STRIP);
  for (int i = 0; i < sides + 1; i++) {
    float x = cos(radians(i * angle)) * r;
    float y = sin(radians(i * angle)) * r;
    body.vertex(x, y, halfHeight);
    body.vertex(x, y, -halfHeight);
  }
  body.endShape(CLOSE);
  cylinder.addChild(body);

  return cylinder;
}

PShape half_cylinder (int sides, float r, float h, boolean cap, float arcAlpha, float offAlpha) {
  PShape cylinder = createShape(GROUP);

  float angle = arcAlpha / sides;
  float halfHeight = h / 2;

  if (cap) {
    PShape top_cap = createShape();
    top_cap.beginShape();
    for (int i = 0; i < sides; i++) {
      float x = cos(radians(i * angle + offAlpha)) * r;
      float y = sin(radians(i * angle + offAlpha)) * r;
      top_cap.vertex(x, y, -halfHeight);
    }
    top_cap.endShape(CLOSE);

    PShape bottom_cap = createShape();
      // draw bottom of the tube
    bottom_cap.beginShape();
    for (int i = 0; i < sides; i++) {
      float x = cos(radians(i * angle + offAlpha)) * r;
      float y = sin(radians(i * angle + offAlpha)) * r;
      bottom_cap.vertex(x, y, halfHeight);
    }
    bottom_cap.endShape(CLOSE);

    cylinder.addChild(top_cap);
    cylinder.addChild(bottom_cap);
  }

    // draw sides
  PShape body = createShape();
  body.beginShape(TRIANGLE_STRIP);
  for (int i = 0; i < sides + 1; i++) {
    float x = cos(radians(i * angle + offAlpha)) * r;
    float y = sin(radians(i * angle + offAlpha)) * r;
    body.vertex(x, y, halfHeight);
    body.vertex(x, y, -halfHeight);
  }
  body.endShape(CLOSE);
  cylinder.addChild(body);

  return cylinder;
}
