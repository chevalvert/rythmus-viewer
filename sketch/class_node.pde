import java.nio.charset.StandardCharsets;

public class Node {
  public String name, info;
  public ArrayList<Pillar> pillars;

  private UDP udp_tx, udp_rx;

  Node (PApplet parent, int id) {
    this.name = NODE_prefix + id;
    this.pillars = new ArrayList<Pillar>();

    int PORT_RX = 6000 + id;
    this.info = name + "//" + PORT_RX;

    this.udp_rx = new UDP(parent, PORT_RX);
    this.udp_rx.listen(true);
    this.udp_rx.setReceiveHandler("receiveHandler_" + id);
  }

  public void register (Pillar p) { this.pillars.add(p); }

  public Node connect (UDP udp) {
    this.udp_tx = udp;
    this.sendInfo();
    return this;
  }

  public void update (byte[] incomingPacket) {
    for (int i = 0; i < this.pillars.size(); i++) {
      Pillar p = this.pillars.get(i);
      if (p == null) return;
      // if (p == null) continue;

      int len = p.leds.length;
      for (int z = 0; z < len; z++) {
        for (int k = 0; k < 3; k++) {
          p.leds[z][k] = int(incomingPacket[(i * len + z) * 3 + k]);

          // if ((i * len + z) * 3 + k > incomingPacket.length) {
          //   println("oob: "+ ((i * len + z) * 3 + k) + " > " + incomingPacket.length);
          // }

          // println(incomingPacket.length + " | " + int(incomingPacket[(i * len + z) * 3 + k]));
        }
      }
    }
    this.sendInfo();
  }

  private void sendInfo () {
    if (this.udp_tx != null) this.udp_tx.send(this.info.getBytes(StandardCharsets.UTF_8));
  }
}
