/*
@ruleset green {color == (0,255,0)}
@ruleset red {color == (255,0,0)}
@ruleset blue {color == (0,0,255)}
@ruleset white {color == (255,255,255)}

@ruleset is_at_top_left {x == 0 && y == 0}
@ruleset green_correct_color {(green ==> is_at_top_left) && (is_at_top_left ==> green)}

@ruleset is_at_bottom_left {x == 0 && y == f.height}
@ruleset red_correct_color {red <=> is_at_bottom_left}

@ruleset is_at_top_right {x == f.width && y == 0}
@ruleset blue_correct_color {blue <=> is_at_top_right}

@ruleset is_at_bottom_right {x == f.width &&y == f.height}
@ruleset white_correct_color {white <=> is_at_bottom_right}

@ruleset red_color_updates {exists Binding(_, fc.r)}
@ruleset green_color_updates {exists Binding(_, fc.g) }
@ruleset blue_color_updates {exists Binding(_, fc.b)}

@ruleset outline_color_existence {exists (OutlineColor as %oc) && ((! exists NoOutline) 
                        || (exists (NoOutline as %no) ==> no:layer == Before(%oc)))}
@ruleset white_outline {outcolor == (255,255,255)}
*/