import peasy.PeasyCam;
import java.util.Iterator;

final int UDP_PORT = 3737;
final boolean PRINT_MAPPING = false;
final boolean OPTIONS_fullscreen = true;
final boolean OPTIONS_randomize_mapping = false;

final int RYTHMUS_radius = 589 / 2;
final int RYTHMUS_length = 34 + 2;

final int PILLAR_height = 180;
final int SENSOR_height = 90;
final int PILLAR_leds_length = 178 / 2;
final int SENSOR_leds_length = 68 / 2;
// NOTE: see rythmus-app::Stripled.js
final int EXPECTED_leds_length = PILLAR_leds_length * 2;

final String NODE_prefix = "fakenode_";


final int PILLAR_height_offset = 30;
final int PILLAR_radius = 10 / 2;
final color PILLAR_color = color(60);

final int PILLAR_face_aperture = 180;
final int PILLAR_face_aperture_offset = (180 - PILLAR_face_aperture) / 2;

final int GUI_padding = 20;
final color COLOR_rhino = color(140, 146, 154);
final color COLOR_gray = color(15);

PeasyCam cam;
Rythmus rythmus;
PShape GUI_environment_human;

boolean is_started = false;

void settings () {
  if (OPTIONS_fullscreen) fullScreen(P3D, 2);
  else size(800, 600, P3D);
}

void setup () {
  rythmus = new Rythmus(this);
  if (!is_started) {
    // NOTE: this allows reseting sketch by calling setup() without messing with the 3D scene viewer
    is_started = true;
    cam = new PeasyCam(this, RYTHMUS_radius * 2.5);
    rythmus.connect(UDP_PORT);
    if (PRINT_MAPPING) rythmus.printNodesMapping();
  } else frameCount = 0;


  GUI_environment_human = loadShape("human.obj");
  GUI_environment_human.setFill(color(35));

  println("rythmus-viewer is running");
}

void draw () {
  background(OPTIONS_darkmode ? COLOR_gray : COLOR_rhino);
  rotateX(radians(90 - 22.5));
  rotateZ(radians(map(RECORD_framecount, 0, 2000, 0, 360)));

  // if (RECORD_framecount > 2000) OPTIONS_record = false;

  // // CLEAR
  // for (Pillar p : rythmus.pillars) {
  //   for (int z = 0; z < p.leds_length * 2; z++) p.leds[z] = new int[]{0, 0, 0};
  // }

  // int z = int(abs(sin(frameCount * 0.02)) * PILLAR_leds_length);
  // int z2 = int(abs(sin(frameCount * 0.03)) * PILLAR_leds_length);
  // for (Pillar p : rythmus.pillars) {
  //   // OUTSIDE
  //   if (z < p.leds_length)  p.leds[z] = new int[]{255, 255, 255};
  //   // INSIDE
  //   if (z2 < p.leds_length) p.leds[(p.leds_length * 2 - 1) - z2] = new int[]{255, 255, 255};
  // }

  rythmus.draw();
  GUI_draw();
}
