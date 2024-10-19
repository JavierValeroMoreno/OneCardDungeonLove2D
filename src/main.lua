function love.load()
    tile_ref =
    {
        0 = "ground",
        1 = "stone",
        2 = "stair_start",
        3 = "stair_goal"
    }
    map = 
    {
        {0, 0, 0, 0, 3},
        {0, 0, 0, 1, 0},
        {0, 0, 0, 0, 0},
        {0, 1, 0, 1, 0},
        {2, 0, 0, 0, 0}
    }
    player = 
    {
        grid_x = 256,
        grid_y = 256,
        act_x = 32,
        act_y = 32,
        speed = 1,
        atk = 1,
        def = 1,
        range = 2
    }

end

function love.draw()

    
    love.graphics.rectangle("fill", player.act_x, player.act_y, 32, 32)

end

function draw_map()
    for 
end

function love.update(dt)
    player.act_y = player.act_y - (player.act_y - player.grid_y)
    player.act_x = player.act_x - (player.act_x - player.grid_x)
end

function love.keypressed(key)
    if key == "down" then
        player.grid_y = player.grid_y + 32
    elseif key == "up" then
        player.grid_y = player.grid_y - 32
    elseif key == "left" then
        player.grid_x = player.grid_x - 32
    elseif key == "right" then
        player.grid_x = player.grid_x + 32
    end
end