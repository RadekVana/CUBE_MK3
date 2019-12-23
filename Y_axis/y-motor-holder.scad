// PRUSA iteration4
// Y motor holder
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org



/*****************************************************************************/
//includes
include <../_includes/MCAD-master/boxes.scad>;
/*****************************************************************************/
//variables
top_screw_to_top_of_profile = 10;

top_motor_screw_y_pos = 5.5;
bot_motor_screw_y_pos = 36.5;
top_motor_screw_z_pos = 41.5;
bot_motor_screw_z_pos = top_motor_screw_z_pos - 31;


base = [7,42,47];

$fn=50;
/*****************************************************************************/
//modules

module y_motor_holder()
{
    difference()
    {
        // base body
        cube(base);

        // shape cuts
        translate([-0.5,21,  26]) rotate([0,90,0]) cylinder( h=base[0]+1, r=11.5);   
        translate([-0.5,21.5,15]) cube([base[0]+1,base[1],base[2]]);
        
        // lower motor screw
        #translate([-26,bot_motor_screw_y_pos, bot_motor_screw_z_pos]) rotate([0,90,0]) cylinder( h=40, r=1.65); 
        translate([-13,bot_motor_screw_y_pos, bot_motor_screw_z_pos]) rotate([0,90,0]) cylinder( h=15, r=3.1);         
        
        // upper motor screw    
        translate([-26,top_motor_screw_y_pos,top_motor_screw_z_pos]) rotate([0,90,0]) cylinder( h=40, r=1.65);         
        translate([-2, top_motor_screw_y_pos,top_motor_screw_z_pos]) rotate([0,90,0]) cylinder( h=4, r=3.1);         
 
        // corners
        translate([-16,21.5,42]) rotate([45,0,0]) cube([60,10,10]);        
        translate([-16,-3.5,42]) rotate([45,0,0]) cube([60,10,10]);        
        translate([-16,39.5,-7]) rotate([45,0,0]) cube([60,20,10]);        
        translate([-16,44.5,10]) rotate([45,0,0]) cube([60,20,20]);  
        translate([12, -8.5,-5]) rotate([0,0,45]) cube([10,10,60]);        
    }
}




module profile()
{
    cube([100,20,20],true);
}

 /*****************************************************************************/
//parts 

y_motor_holder();    

translate([0,-10,top_motor_screw_z_pos-10-top_screw_to_top_of_profile]) profile();
//import("y-motor-holder.stl");   
    