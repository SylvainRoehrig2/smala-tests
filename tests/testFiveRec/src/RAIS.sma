<global>
/*
@ruleset red {color.r == 255 && color.g == 0 && color.b == 0}
@ruleset green {color.r == 0 && color.g == 255 && color.b == 0}
@ruleset blue {color.r == 0 && color.g == 0 && color.b == 255}
@ruleset is_at_bottom {layer == Bottom}
@ruleset is_at_top {layer == Top}
*/
</global>

<component>
Rectangle {
/*
@ruleset correct_width {width == 100}
@ruleset correct_height {height == 50}
*/
}
</component>

<local>
redRec {
/*
@ruleset correct_width {width == 50}
@ruleset correct_height {height == 100}
*/
}
greenRec {
/*
@ruleset correct_width {width == 150}
@ruleset correct_height {height == 100}
@ruleset is_top_and_green {is_at_top && green}
*/
}
</local>