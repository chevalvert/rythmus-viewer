import java.util.Collections;

public class Rythmus {
  private PApplet parent;
  public ArrayList<Node> nodes;
  public ArrayList<Pillar> pillars;

  Rythmus (PApplet parent) {
    this.parent = parent;
    this.pillars = new ArrayList<Pillar>();
    for (int index = 0; index < RYTHMUS_length; index++) {
      float theta = map(index, 0, RYTHMUS_length, 0, TWO_PI);
      float x = sin(theta) * RYTHMUS_radius;
      float y = cos(theta) * RYTHMUS_radius;
      if (index % (RYTHMUS_length / 2) == 0) {
        this.pillars.add(new Pillar(index, new PVector(x, y), SENSOR_height, SENSOR_leds_length, -theta));
      } else {
        this.pillars.add(new Pillar(index, new PVector(x, y), PILLAR_height, PILLAR_leds_length, -theta));
      }
    }

    this.nodes = bundlePillars(this.pillars, 4);
  }

  private ArrayList<Node> bundlePillars (ArrayList<Pillar> pillars, int bundleLength) {
    ArrayList<Node> nodes = new ArrayList<Node>();
    Node curNode = new Node(this.parent, 0);

    if (OPTIONS_randomize_mapping) Collections.shuffle(pillars);

    for (Pillar pillar : pillars) {
      if (curNode.pillars.size() + 1 > bundleLength) {
        nodes.add(curNode);
        curNode = new Node(this.parent, nodes.size());
      }
      curNode.register(pillar);
    }

    if (!nodes.contains(curNode)) nodes.add(curNode);
    return nodes;
  }

  // -------------------------------------------------------------------------

  public void connect (int port) {
    UDP udp = new UDP(this.parent, port);
    for (Node n : this.nodes) n.connect(udp);
  }

  public void draw () {
    for (Pillar p : this.pillars) p.draw();
  }

  public Pillar get (int id) { return this.pillars.get(id); }

  public void printNodesMapping () {
    JSONObject json = new JSONObject();
    for (Node node : this.nodes) {
      JSONArray pillarsIndexes = new JSONArray();
      for (Pillar p : node.pillars) pillarsIndexes.append(p.index);
      json.setJSONArray(node.name, pillarsIndexes);
    }
    println(json);
  }
}
