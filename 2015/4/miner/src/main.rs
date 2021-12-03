use md5::{Md5, Digest};
use std::io;

fn main() {
  let mut hasher = Md5::new();
  let mut input = String::new();
  io::stdin().read_line(&mut input).expect("could not read input");
  let key = input.trim();
  for i in 0..std::u64::MAX {
    hasher.update(key);
    hasher.update(i.to_string());
    
    let output = hasher.finalize_reset();

    //if output[..2] == [0, 0] && output[2] <= 0x0F {
    if output[..3] == [0, 0, 0] {
      println!("{}", i);
      break;
    }
  }
}
