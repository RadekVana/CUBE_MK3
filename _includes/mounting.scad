/*****************************************************************************/
//variables
PROFILE_SZ = 20;
PROFILE_SCREW_HEAD_D = 12;
PROFILE_SCREW_D = 5;
PROFILE_SCREW_LEN_SHORT = 8;
PROFILE_SCREW_LEN_LONG = 10;

/*****************************************************************************/
//modules
module profile_screw_hole(head_len, body_len)
{
    translate([0,0,-0.1-body_len])cylinder(d = PROFILE_SCREW_D + 0.2, h = body_len + 0.2);
    translate([0,0,0])cylinder(d = PROFILE_SCREW_HEAD_D + 0.5, h = head_len + 0.1);
}

module profile_screw_hole_long(head_len)
{
    profile_screw_hole(head_len, PROFILE_SCREW_LEN_LONG);
}

module profile_screw_hole_short(head_len)
{
    profile_screw_hole(head_len, PROFILE_SCREW_LEN_SHORT);
}