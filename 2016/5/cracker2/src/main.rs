use md5::{Md5, Digest};
use std::io;
use std::io::Write;

fn main() {
  let mut hasher = Md5::new();
  let mut input = String::new();
  let mut count = 0;
  let mut password = [16;8];
  io::stdin().read_line(&mut input).expect("could not read input");
  let key = input.trim();
  for i in 0..std::u64::MAX {
    hasher.update(key);
    hasher.update(i.to_string());

    let output = hasher.finalize_reset();

    if output[..2] == [0, 0] && output[2] < 0x08 &&
      password[output[2] as usize] == 16 {

      password[output[2] as usize] = output[3] >> 4;
      count += 1;
    }
    
    if i % 0x10000 == 0 || count == 8 {
      print!("\r");
      for j in 0..8 {
        if password[j] == 16 {
          print!("{}", (output[4+j as usize] & 0x07 | 0x28) as char);
        } else {
          print!("{:x}",password[j]);
        } 
      }
      io::stdout().flush().ok();
      if count == 8 {
        print!("\n");
        break;
      }
    }
  }
}
