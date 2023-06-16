<global>
/*
@ruleset $green {color == (200,255,0)}
@ruleset $red {color == (200,0,0)}
@ruleset $rectangles_never_blue {Rectangle:color.b == 0}
@ruleset $rectangles_at_bottom {rleft:layer == Before(l) && rright:layer == Before(l)}
@ruleset $correct_height {height == f:height}
@ruleset $button_updated {exists Assignement(b:text)}
*/
</global>

<local>
l {
/*
@ruleset $red {color == (255,0,0)}
*/
}
</local>