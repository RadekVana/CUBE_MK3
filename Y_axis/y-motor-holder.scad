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

top_motor_screw_z_pos = 41.5;
bot_motor_screw_z_pos = top_motor_screw_z_pos - 31;

$fn=50;
/*****************************************************************************/
//modules

module y_motor_holder()
{
    difference()
    {
        // base body
        translate([-6,0,0]) cube([19,42,47]);

        // shape cuts
        translate([-20,21,  26]) rotate([0,90,0]) cylinder( h=35, r=11.5, $fn=50 );   
        translate([-11,21.5,15]) cube([26,23,64]);
        translate([-20,6,   -1]) cube([26,41,64]);
        translate([-20,-3.5,37]) cube([26,21,20]);
        translate([-20,0.5, 37]) cube([26,30,20]);
        
        // lower motor screw
        translate([-20,36.5, bot_motor_screw_z_pos]) rotate([0,90,0]) cylinder( h=40, r=1.65, $fn=50 ); 
        translate([-7 ,36.5, bot_motor_screw_z_pos]) rotate([0,90,0]) cylinder( h=15, r=3.1, $fn=50 );         
        
        // upper motor screw    
        translate([-20,5.5,top_motor_screw_z_pos]) rotate([0,90,0]) cylinder( h=40, r=1.65, $fn=50 );         
        translate([4,  5.5,top_motor_screw_z_pos]) rotate([0,90,0]) cylinder( h=4, r=3.1, $fn=50 );         
 
        // corners
        translate([-10,21.5,42]) rotate([45,0,0]) cube([60,10,10]);        
        translate([-10,-3.5,42]) rotate([45,0,0]) cube([60,10,10]);        
        translate([-10,39.5,-7]) rotate([45,0,0]) cube([60,20,10]);        
        translate([-10,44.5,10]) rotate([45,0,0]) cube([60,20,20]);  
        translate([-14,-8.5,-2]) rotate([0,45,0]) cube([10,50,10]);        
        translate([-14,-8.5,37]) rotate([0,45,0]) cube([10,50,10]);        
        translate([18, -8.5,-5]) rotate([0,0,45]) cube([10,10,60]);        
    }
    
    // reinforcement
    translate([7.8,3.4,0]) rotate([0,0,55]) cube([5,5,18]);
    difference()
        {
            translate([7.8,3.4,13.6]) rotate([0,0,55]) cube([5,5,23.4]);
            translate([-20,21   ,26]) rotate([0,90,0]) cylinder( h=35, r=12, $fn=30 );   
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
    