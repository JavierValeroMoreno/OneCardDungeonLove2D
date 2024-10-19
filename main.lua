function love.load()
    tile_atlas = love.graphics.newImage("media/groundTiles.png")
    sprite_dim = 32
    scale_factor = 2
    tile_ref = {}
    tile_ref[0] = love.graphics.newQuad(0, 0, 32, 32, tile_atlas)
    tile_ref[1] = love.graphics.newQuad(64, 0, 32, 32, tile_atlas)
    tile_ref[2] = love.graphics.newQuad(96, 0, 32, 32, tile_atlas)
    tile_ref[3] = love.graphics.newQuad(96, 0, 32, 32, tile_atlas)

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

    draw_map()
    love.graphics.rectangle("fill", player.act_x, player.act_y, 32, 32)

end

function draw_map()
    for row, rval in ipairs(map) do
        for col, cval in ipairs(rval) do
            love.graphics.draw(tile_atlas, tile_ref[cval], (row - 1) * sprite_dim * scale_factor, (col - 1)  * sprite_dim * scale_factor, 0, scale_factor)
        end
    end
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