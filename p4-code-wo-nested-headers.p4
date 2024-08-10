header id_1_h {
  bit<2>      type;
  bit<6>      if1;
  bit<8>      if2;
  bit<16>     if3;
}
header id_2_h {
  bit<2>      type;
  bit<15>     if1;
  bit<15>     if2;
}
header_union id_t {
  id_1_h      id_t_1;
  id_2_h      id_t_2;
}
header main_part_1_h {
  bit<32>     f1;
}
header main_part_2_h {
  bit<32>     f2;
}
struct headers_t {
  ... // other headers
  main_part_1_h   mh1;
  id_1_h          ida;
  main_part_2_h   mh2;
  id_2_h          idb;
}
parser id_parser(packet_in b, out id_t id) {
  state start {
    transition select(b.lookahead<bit<2>>()) {
      (2w0): parse_type1;
      (2w1): parse_type2;
    }
  }
  state parse_type1 {
    b.extract(id.id_t_1);
    transition accept;
  }
  state parse_type2 {
    b.extract(id.id_t_2);
    transition accept;
  }
}
parser p(packet_in b, out headers_t h...) {
  state start {
    b.extract(h.mh1); 
    id_parser.apply(b, h.ida);
    b.extract(h.mh2); 
    id_parser.apply(b, h.idb);
  }
}
