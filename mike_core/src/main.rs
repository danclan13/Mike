use std::error::Error;
use std::thread;
use std::char;
use std::time::Duration;
use rpi_embedded::uart::{Parity, Uart};
use rpi_embedded::i2c::I2c;
//extern crate pid;
//use pid::Pid;
pub const PI: f64 = 3.14159265358979323846264338327950288f64;


fn main() -> Result<(), Box<dyn Error>> {

    let mut uart = Uart::new(115_200, Parity::None, 8, 1)?;
    let mut i2c = I2c::new()?;
    i2c.set_slave_address(0x53)?;

    //let mut pidx = Pid::new(2.50, 0.005, 0.02, 97.0, 97.0, 97.0, 97.0, 0.0);

    loop {
        for x in 1..100 {
        thread::sleep(Duration::from_millis(10));

        let s = uart.read_line().unwrap_or_default();
        if s.trim().is_empty() == false {
        let spl = s.trim().split(",");
        let vectstr: Vec<&str> = spl.collect();
        if vectstr[0] == "hld" && vectstr[4] == "end"
        {
        let heading = vectstr[1].parse::<f64>().unwrap_or_default();
        let leaning = vectstr[2].parse::<f64>().unwrap_or_default();}}
        //let direction = vectstr[3].parse::<f64>().unwrap_or_default();

        let mut direction = 0.0;

        let mut angle1 = PI/3.0+direction*PI/1800.0;
        let mut angle2 = PI/3.0-direction*PI/1800.0;
        let mut angle3 = direction*PI/1800.0;
        

        //let outputx = pidx.next_control_output(leaning_xpart);
        //let mut vx = outputx.output;

        
        let mut v = 20.0;

 
        let v1 = v*(angle1.cos())+80.0;
        let v2 = v*(angle2.cos())+80.0;
        let v3 = -1.0*v*(angle3.cos())+80.0;
        
        let mut buffer_w = [251,v1 as u8,252,v2 as u8,253,v3 as u8,0xA,0xD];  // needs a flush
        i2c.block_write(0x01, &mut buffer_w).unwrap_or_default();
        println!("Lx: {} Vx: {}", direction, v);
        }
        let mut direction = 0.0;
        let mut angle1 = PI/3.0+direction*PI/1800.0;
        let mut angle2 = PI/3.0-direction*PI/1800.0;
        let mut angle3 = direction*PI/1800.0;

        
        let mut v = 0.0;
        let v1 = v*(angle1.cos())+80.0;
        let v2 = v*(angle2.cos())+80.0;
        let v3 = -1.0*v*(angle3.cos())+80.0;
        
        let mut buffer_w = [251,v1 as u8,252,v2 as u8,253,v3 as u8,0xA,0xD];  // needs a flush
        i2c.block_write(0x01, &mut buffer_w).unwrap_or_default();
        println!("Lx: {} Vx: {}", direction, v);
        
    }
}