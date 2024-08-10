bit<10> match_address;
table TCAM_RAM {
  key = {...}
  actions = {
    ...;
  }
  size=1024;
}
TCAM_RAM.apply();
if (TCAM_RAM.result.hit) {
    match_address = TCAM_RAM.result.index; 
    // use match_address 
    // for further processing
  }
}
