//
// Copyright © 2019 PixelExperience Project
//
// SPDX-License-Identifier: GPL-3.0
//

use std::fs;
use json;
fn main() {
    println!("Linting Devices JSON....");
    let data = fs::read_to_string("devices.json").expect("Unable to read file");
    let parsed = json::parse(&data).unwrap();
    let c = json::stringify_pretty(parsed,3);
    fs::write("devices.json", c).expect("Unable to write file");
    println!("Linted....");
}
