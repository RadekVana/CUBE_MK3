// PRUSA iteration4
// Y holder front
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

//CUBE printer - mk3 modification by Radek Vana


/*****************************************************************************/
//includes
include <../_includes/dimensions_mk3.scad>;
include <../_includes/dimensions_cube.scad>;
include <../_includes/MCAD-master/boxes.scad>;
/*****************************************************************************/
//variables
dep_mk3 = 10;//originallen on mk3 printer
wid = 26;
dep = (CUBE_ROD_Y_LEN - MK3_ROD_Y_LEN)/2 - dep_mk3;//was 10
hei = 11.5;//was 12

rod_z_pos = 10;//was 10.5
rod_d = MK3_ROD_DIA;
rod_d_edge = rod_d + 1;
rod_h_edge = 2;
rod_d_edge2 = rod_d + 2;
rod_h_edge2 = 1.4;

mount_wid = 50;
mount_hei = 5;

edge_r = 1;

$fn=50;
/*****************************************************************************/
//modules
module ziptie_round_edge()
{
    difference()
    {
        translate([0,0,0])      rotate([90,0,0]) cylinder( h=3.2, r=4 );  
        translate([0,1,0])      rotate([90,0,0]) cylinder( h=5, r=2 );  
        translate([-10,-4,0])   cube([20,5,5]);
        translate([-20,-4,-13]) cube([20,5,20]);
    }
}


module _part()    
{

    difference()
    {
        union()
        {
            // body block
            difference() {
                //translate([-wid/2,0,0]) cube([wid,dep,hei]);
                translate([0,dep/2,hei/2]) rotate([0,90,0])roundedBox([hei,dep,wid], edge_r,true);

                // upper corners
                translate([4,    -0.5,   20]) rotate([0,60,0])   cube([20,dep+1,20]);
                translate([-21.2,-0.5,   30]) rotate([0,120,0])  cube([20,dep+1,20]);
            }
        }

        // y-axis cut
        translate([+0, 0,     rod_z_pos])   rotate([-90, 0,0]) cylinder( h=dep,         d=rod_d);
        translate([+0, dep+1, rod_z_pos])   rotate([ 90, 0,0]) cylinder( h=rod_h_edge,  d1=rod_d_edge,  d2=rod_d);
        translate([+0, -1,    rod_z_pos])   rotate([-90, 0,0]) cylinder( h=rod_h_edge,  d1=rod_d_edge,  d2=rod_d);
        translate([+0, dep+1, rod_z_pos])   rotate([ 90, 0,0]) cylinder( h=rod_h_edge2, d1=rod_d_edge2, d2=rod_d);
        translate([+0, -1,    rod_z_pos])   rotate([-90, 0,0]) cylinder( h=rod_h_edge2, d1=rod_d_edge2, d2=rod_d);
        translate([-7, -0.5,  rod_z_pos+4]) rotate([  0,45,0]) cube([rod_d+2, dep+1, rod_d+2]);//edge

        
        // ziptie
        translate([+7.8, dep - 1.25 ,9])                    ziptie_round_edge();
        translate([-7.8, dep - 4.45, 9])  rotate([0,0,180]) ziptie_round_edge();
        translate([-8.1, dep - 4.45, 5])                    cube([16.2,3.2,2]);
        translate([+0.8, dep - 4.45, 25]) rotate([0,60,0])  cube([20,3.2,2]);
        translate([-1.8, dep - 4.45, 27]) rotate([0,120,0]) cube([20,3.2,2]);

    }
}

module _mount()
{
    translate([0,dep/2,mount_hei/2]) roundedBox([mount_wid,dep,mount_hei], edge_r);//cube([mount_wid,dep,5]);
}

module part() 
{
    difference()
    {
        union()
        {
            _part();
            _mount();
        }
    }
}

/*****************************************************************************/
//part
part();


