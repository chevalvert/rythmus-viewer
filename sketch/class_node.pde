import java.nio.charset.StandardCharsets;

public class Node {
  public String name, info;
  public ArrayList<Pillar> pillars;

  private UDP udp_tx, udp_rx;

  Node (PApplet parent, int id) {
    this.name = NODE_prefix + id;
    this.pillars = new ArrayList<Pillar>();

    int PORT_RX = 6000 + id;
    int VERSION = 0;
    this.info = name + "//" + PORT_RX + "//" +  VERSION;

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
    // NOTE: first by of payload is either 0 or 2
    // 0 => first couple of strips (#0 and #1)
    // 1 => second couple of strips (#2 and #3)
    int offset = int(incomingPacket[0]);
    if (offset != 0 && offset != 2) return;

    // TODO: variable size
    for (int i = 0; i < 2; i++) {
      Pillar p = this.pillars.get(i + offset);
      if (p == null) continue;

      for (int z = 0; z < p.leds.length; z++) {
        for (int k = 0; k < 3; k++) {
          int index = (1 + i) + (i * EXPECTED_leds_length + z) * 3 + k;
          p.leds[z][k] = int(incomingPacket[index]);
        }
      }
    }
    this.sendInfo();
  }

  private void sendInfo () {
    if (this.udp_tx != null) this.udp_tx.send(this.info.getBytes(StandardCharsets.UTF_8));
  }
}
