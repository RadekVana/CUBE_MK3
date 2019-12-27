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
include <../_includes/mounting.scad>;
include <../_includes/MCAD-master/boxes.scad>;
/*****************************************************************************/
//variables
dep_mk3 = 10;//originallen on mk3 printer
wid = 26;
dep = PROFILE_SZ;
dep2 = (ROD_Y_LEN - MK3_ROD_Y_LEN)/2 + 2*dep_mk3;
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

ziptie_width = 3.2;
ziptie_pos = 1.25;
$fn=50;
/*****************************************************************************/
//modules
module ziptie_round_edge()
{
    difference()
    {
        translate([0,0,0])      rotate([90,0,0]) cylinder( h=ziptie_width, r=4 );  
        translate([0,1,0])      rotate([90,0,0]) cylinder( h=5, r=2 );  
        translate([-10,-4,0])   cube([20,5,5]);
        translate([-20,-4,-13]) cube([20,5,20]);
    }
}

module zip_hole(ypos)
{
        // ziptie
        translate([+7.8, ypos+ziptie_width, 9])          ziptie_round_edge();
        translate([-7.8, ypos,     9]) rotate([0,0,180]) ziptie_round_edge();
        translate([-8.1, ypos,     5])                   cube([16.2,ziptie_width,2]);
        translate([+0.8, ypos,    25]) rotate([0,60,0])  cube([20,ziptie_width,2]);
        translate([-1.8, ypos,    27]) rotate([0,120,0]) cube([20,ziptie_width,2]);
}

module _part(dep)    
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

        
    }
}

module _mount(dep)
{
    translate([0,dep/2,mount_hei/2]) roundedBox([mount_wid,dep,mount_hei], edge_r);//cube([mount_wid,dep,5]);
}

module part() 
{
    difference()
    {
        union()
        {
            _part(dep);
            _mount(dep);
        }

        translate([+16,dep/2,mount_hei-0.2])profile_screw_hole_long(hei-mount_hei);
        translate([-16,dep/2,mount_hei-0.2])profile_screw_hole_long(hei-mount_hei);
        zip_hole(dep - ziptie_width - ziptie_pos);
        zip_hole(ziptie_pos);
    }
}


module part2() 
{
    difference()
    {
        union()
        {
            _part(dep2);
            _mount(dep);
        }

        translate([+16,dep/2,mount_hei-0.2])profile_screw_hole_long(hei-mount_hei);
        translate([-16,dep/2,mount_hei-0.2])profile_screw_hole_long(hei-mount_hei);
        zip_hole(dep - ziptie_width - ziptie_pos);
        zip_hole(ziptie_pos);
        zip_hole(dep2 - ziptie_width - ziptie_pos);
    }
}
/*****************************************************************************/
//parts
//part();
//Prusa slicer has some isues if it is not rotated, so I rotate it here, than rotate it back in slicer
//rotate([90,0,0])part2();
rotate([90,0,0])part();

