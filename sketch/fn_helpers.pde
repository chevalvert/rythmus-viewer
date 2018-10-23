final float EPSILON = 0.001;

float leds (int n) {
  return n * (1 / PILLAR_leds_length);
}

float positive_sin (float v) {
  return (sin(v) + 1) / 2;
}

float positive_cos (float v) {
  return (cos(v) + 1) / 2;
}

boolean odd (int v) {
  return v % 2 != 0;
}

String timestamp () {
  return year() + "" + month() + "" + day() + "-" + hour() + "" + minute() + "" + second();
}
