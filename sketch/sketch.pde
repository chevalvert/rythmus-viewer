import peasy.PeasyCam;
import java.util.Iterator;

final boolean OPTIONS_fullscreen = true;

final int RYTHMUS_radius = 589 / 2;
final int RYTHMUS_length = 34 + 2;
final String NODE_prefix = "fakenode_";

final int PILLAR_height = 180;
final int PILLAR_height_offset = 30;
final int PILLAR_leds_length = 90;
final int PILLAR_radius = 10 / 2;
final color PILLAR_color = color(60);

final int PILLAR_face_aperture = 180;
final int PILLAR_face_aperture_offset = (180 - PILLAR_face_aperture) / 2;

final int SENSOR_height = 180; // TODO 90

final int GUI_padding = 20;


final color COLOR_rhino = color(140, 146, 154);
final color COLOR_gray = color(15);

PeasyCam cam;
Rythmus rythmus;
PShape GUI_environment_human;

boolean is_started = false;

void settings () {
  if (OPTIONS_fullscreen) fullScreen(P3D, 2);
  else size(800, 800, P3D);
}

void setup () {
  if (!is_started) {
    // NOTE: this allows reseting sketch by calling setup() without messing with the 3D scene viewer
    is_started = true;
    cam = new PeasyCam(this, RYTHMUS_radius * 2.5);
  }

  rythmus = new Rythmus(this);
  rythmus.connect(3737);
  rythmus.printNodesMapping();

  GUI_environment_human = loadShape("human.obj");
  GUI_environment_human.setFill(color(35));
}

void draw () {
  background(OPTIONS_darkmode ? COLOR_gray : COLOR_rhino);
  rotateX(radians(90 - 22.5));
  rotateZ(radians(90 + 22.5 + map(RECORD_framecount, 0, 2000, 0, 360)));

  // if (RECORD_framecount > 2000) OPTIONS_record = false;

  // int index = int(frameCount * 0.05) % RYTHMUS_length;
  // Pillar p = rythmus.pillars.get(index);
  // for (int z = 0; z < PILLAR_leds_length * 2; z++) {
  //   p.leds[z] = new int[]{255, 255, 255};
  // }

  rythmus.draw();
  GUI_draw();
}
