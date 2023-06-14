/////////GLOBAL/////////
<global>
/*
@ruleset red {color.r == 255}
@ruleset green {color.g == 255}
@ruleset moveable_x_axis {exists Assignement(x)}
@ruleset is_up_to_date {true}
*/
</global>

/////////COMPONENT/////////
<component>
Rectangle {
    /*
    @ruleset red {color.r == 200 && color.g <= 255/3}
    @ruleset moveable_y_axis {exists Binding(y) || exists Assignement(y)}
    */
}
</component>

/////////LOCAL/////////
<local>
b {
    //@ruleset is_up_to_date {exists Assignement(text)}
}

</local>