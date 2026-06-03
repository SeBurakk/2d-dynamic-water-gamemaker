
wave_timer += 0.03; 

for(var i = 0; i < nodes; i++) 
{
	var _wave_1 = sin(wave_timer + (i * 0.6)) * 1.5; 
	var _wave_2 = cos((wave_timer * 1.5) + (i * 1.2)) * 0.5;
    var _target_y = water_level + _wave_1 + _wave_2;
    var _displacement = node_y[i] - _target_y;
    
    node_v[i] -= tension * _displacement;
    node_v[i] *= (1 - dampening);
    node_y[i] += node_v[i];
}

for(var j = 0; j < 4; j++) 
{ 
    for(var i = 0; i < nodes; i++) 
    {
        if(i > 0) node_y[i-1] += spread * (node_y[i] - node_y[i-1]);
        if(i < nodes - 1) node_y[i+1] += spread * (node_y[i] - node_y[i+1]);
    }
}
