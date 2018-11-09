boolean OPTIONS_record = false;
boolean OPTIONS_darkmode = true;
boolean OPTIONS_floor = false;
boolean OPTIONS_environment = false;
boolean OPTIONS_informations = false;

String RECORD_timestamp;
int RECORD_framecount;

void keyPressed () {
  switch (key) {
    case 'd' : OPTIONS_darkmode = !OPTIONS_darkmode; break;
    case 'e' : OPTIONS_environment = !OPTIONS_environment; break;
    case 'g' : OPTIONS_floor = !OPTIONS_floor; break;
    case 'i' : OPTIONS_informations = !OPTIONS_informations; break;
    case 'r' : setup(); break;
    case 's' : {
      RECORD_framecount = 0;
      RECORD_timestamp = timestamp();
      OPTIONS_record = !OPTIONS_record;
      break;
    }
  }
}

void GUI_draw () {
  if (OPTIONS_environment) GUI_draw_environment();
  if (OPTIONS_floor) GUI_draw_floor();

  cam.beginHUD();
  if (OPTIONS_informations) {
    GUI_draw_informations();
  }
  cam.endHUD();

  if (OPTIONS_record) record();

  cam.beginHUD();
  GUI_fps();
  cam.endHUD();
}

void GUI_draw_informations () {
  textAlign(LEFT, BOTTOM);
  text(
    "[d] TOGGLE DARK MODE\n"+
    "[e] SHOW/HIDE ENVIRONMENT\n"+
    "[g] SHOW/HIDE FLOOR\n"+
    "[i] SHOW/HIDE INFO\n"+
    "[r] RESET\n"+
    "[s] TOGGLE FRAMES RECORDING", GUI_padding, height - GUI_padding);
}

void GUI_draw_environment () {
  pushStyle();
  for (int i = 0; i < 2; i++) {
    pushMatrix();
      rotate(radians(90 - (180 / 46) + 180 * i));
      pushMatrix();
        translate(RYTHMUS_radius + 50, 0, 0);
        scale(0.1);
        rotate(radians(180));
        shape(GUI_environment_human, 0, 0);
      popMatrix();
    popMatrix();
  }
  popStyle();
}

void GUI_draw_floor () {
  int size = RYTHMUS_radius * 2;
  float steps = 10;
  pushStyle();
  for (int x = -size; x <= size; x += size * 2 / steps) line(x, -size, x, size);
  for (int y = -size; y <= size; y += size * 2 / steps) line(-size, y, size, y);
  popStyle();
}

void GUI_fps () {
  String fps = int(frameRate) + "fps";
  if (OPTIONS_fullscreen) {
    textAlign(RIGHT, BOTTOM);
    pushStyle();
    fill(255);
    text(fps, width - GUI_padding, height - GUI_padding);
    popStyle();
  } else {
    surface.setTitle(fps);
  }
}

void record () {
  saveFrame("export_" + RECORD_timestamp + "/####.tif");
  cam.beginHUD();
  textAlign(RIGHT, TOP);
  pushStyle();
  fill(255);
  text(++RECORD_framecount, width - GUI_padding, GUI_padding);
  popStyle();
  cam.endHUD();
}
