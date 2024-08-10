header id_1_h {
  bit<6>      if1; 
  bit<8>      if2; 
  bit<16>     if3; 
}
header id_2_h {
  bit<15>     if1;        
  bit<15>     if2;
}
header_union id_t {
  id_1_t      id_t_1;
  id_2_t      id_t_2;
}
struct type_id_t {
  bit<2>      type;
  id_t        id;
}
header main_h {
  bit<32>     f1;
  type_id_t   id_a;
  bit<32>     f2;
  type_id_t   id_b;
}
struct headers_t {
  ... // other headers
  main_h      mh;
}
parser p(packet_in b, out headers_t h...) {
  state start {
    b.extract(h.mh);
    id_parser(h.mh.id_a.type, h.mh.id_a.id);
    id_parser(h.mh.id_b.type, h.mh.id_b.id);
  }
}
parser id_parser(bit<2> type, header_union id) {
  state start {
    b.extract(h.mh);
    transition select(type) {
      (2w0): parse_type1;
      (2w1): parse_type2;
    }
  }
  state parse_type1 {
    id.id_t_1.setValid();
    transition accept;
  }
  state parse_type2 {
    id.id_t_2.setValid();
    transition accept;
  }
}
