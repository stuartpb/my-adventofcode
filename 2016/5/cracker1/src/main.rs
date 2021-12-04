use md5::{Md5, Digest};
use std::io;
use std::io::Write;

fn main() {
  let mut hasher = Md5::new();
  let mut input = String::new();
  let mut count = 0;
  io::stdin().read_line(&mut input).expect("could not read input");
  let key = input.trim();
  for i in 0..std::u64::MAX {
    hasher.update(key);
    hasher.update(i.to_string());
    
    let output = hasher.finalize_reset();

    if output[..2] == [0, 0] && output[2] <= 0x0F {
      print!("{:x}", output[2]);
      io::stdout().flush().ok();
      count += 1;
      if count == 8 {
        print!("\n");
        break;
      }
    }
  }
}
