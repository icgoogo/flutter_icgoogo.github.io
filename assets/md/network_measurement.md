### Encrypted Network Traffic Analysis & Fingerprinting Pipeline

An end-to-end network data collection and processing pipeline that captures live HTTPS traffic, parses raw `.pcap` packet streams, and engineers statistical feature sets for encrypted website fingerprinting and side-channel traffic analysis.

- **Automated Packet Sniffing:** Automated live traffic capture via `tcpdump` using Berkeley Packet Filters (`port 443`, `port 53`) and systematic local DNS flushing (`dscacheutil`/`mDNSResponder`) to prevent routing artifacts.
- **PCAP Parsing Engine:** Built headless `tshark` extraction scripts to convert binary packet captures into structured CSVs, tracking directional flows (uplink/downlink) across dynamic IP environments.
- **Side-Channel Feature Engineering:** Derived a 20-feature statistical dataset covering packet size distributions and Inter-Arrival Times (IAT) to enable passive traffic classification without packet decryption.

**Tech Stack:** `Python` • `Pandas` • `NumPy` • `tcpdump` • `tshark` • `Bash` • `Wireshark`

👉 **[Explore the Repository on GitHub](https://github.com/icgoogo/network_measurement_lab/tree/main)**
