//CUBE printer - mk3 Z motor holder by Radek Vana

/*****************************************************************************/
//includes
include <../_includes/MCAD-master/boxes.scad>;
include <../_includes/MCAD-master/motors.scad>;
include <../_includes/mounting.scad>;
/*****************************************************************************/
//variables

motor_sz = FRONT_PROFILE_LEN - MK3_Z_TRAPESOID_DIST;
echo(str("motor_sz = ", motor_sz));
assert(motor_sz > 42.5, "motor cannot fit");

wall_sz = 8;
slide_distance = 0;

top_plate = [motor_sz + 2 * PROFILE_SZ, motor_sz,wall_sz];
trapesoud_rod_dist = 17;
$fn=50;

cut = [2*(top_plate[0]/2-trapesoud_rod_dist),16,wall_sz+0.2];//x is centered .. 2x so i do not have to translate it

/*****************************************************************************/
//modules

module rod_cut(h, w = 16)
{
    cut = [2*(top_plate[0]/2-trapesoud_rod_dist+0.1),w+0.2,h+0.2];//x is centered .. 2x so i do not have to translate it
    translate([-top_plate[0]/2,0,(wall_sz+0.1)/2])roundedBox(cut, 1, true);
    translate([-trapesoud_rod_dist,0,-0.1])cylinder(d=8, h=h+0.2);
}


/*****************************************************************************/
//parts 


#translate([0,0,-5])cube([motor_sz,motor_sz,10],true);

difference()
{
translate([0,0,wall_sz/2])roundedBox(top_plate, 1, true);
translate([0,0,-0.1])linear_extrude(wall_sz + 0.2) stepper_motor_mount(17,slide_distance=slide_distance, mochup=true, tolerance=0.2);

rod_cut(h = wall_sz);
//translate([-top_plate[0]/2,0,(wall_sz+0.1)/2])roundedBox(cut, 1, true);
}