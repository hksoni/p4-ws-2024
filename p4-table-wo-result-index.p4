bit<10> match_address;
action index_store(bit<10> index) {
  match_address = index;
}
table tcam_lookup {
  key = {...} 
  actions = {
    index_store;
  }
  size=1024;
}
table RAM {
  key = { match_address: exact; }
  actions = {
    ...; 
  }
  size=1024;
}
apply {
  if (tcam_lookup.apply().hit) {
    RAM.apply();
    // use match_address 
    // for further processing
  }
}
