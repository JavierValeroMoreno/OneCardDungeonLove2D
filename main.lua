function love.load()
    tile_atlas = love.graphics.newImage("media/groundTiles.png")
    enemies_atlas = love.graphics.newImage("media/enemiesSprites.png")
    dice_atlas = love.graphics.newImage("media/diceTiles.png")
    icon_atlas = love.graphics.newImage("media/iconSprites.png")

    spd = 20
    sprite_dim = 32
    enemies_dim = 16
    scale_factor = 3

    start = true

    map_left_padding = 20
    map_height = sprite_dim * 5 * scale_factor
    enemy_gui_height = sprite_dim * scale_factor
    player_gui_height = sprite_dim * 2 * scale_factor
    tile_ref = {}
    tile_ref[0] = love.graphics.newQuad(0, 0, sprite_dim, sprite_dim, tile_atlas)
    tile_ref[1] = love.graphics.newQuad(64, 0, sprite_dim, sprite_dim, tile_atlas)
    tile_ref[2] = love.graphics.newQuad(96, 0, sprite_dim, sprite_dim, tile_atlas)
    tile_ref[3] = love.graphics.newQuad(96, 0, sprite_dim, sprite_dim, tile_atlas)

    icon_ref = {
        speed = love.graphics.newQuad(0, 0, enemies_dim, enemies_dim, icon_atlas),
        atk = love.graphics.newQuad(16, 0, enemies_dim, enemies_dim, icon_atlas),
        def = love.graphics.newQuad(32, 0, enemies_dim, enemies_dim, icon_atlas),
        range = love.graphics.newQuad(48, 0, enemies_dim, enemies_dim, icon_atlas),
    }
    dice_ref = {
        enemy_dice = {
            love.graphics.newQuad(0, 64, sprite_dim, sprite_dim, dice_atlas),
            love.graphics.newQuad(32, 64, sprite_dim, sprite_dim, dice_atlas),
            love.graphics.newQuad(64, 64, sprite_dim, sprite_dim, dice_atlas),
            love.graphics.newQuad(96, 64, sprite_dim, sprite_dim, dice_atlas),
            love.graphics.newQuad(128, 64, sprite_dim, sprite_dim, dice_atlas),
            love.graphics.newQuad(160, 64, sprite_dim, sprite_dim, dice_atlas)
        },
        player_dice = {
            love.graphics.newQuad(0, 0, sprite_dim, sprite_dim, dice_atlas),
            love.graphics.newQuad(32, 0, sprite_dim, sprite_dim, dice_atlas),
            love.graphics.newQuad(64, 0, sprite_dim, sprite_dim, dice_atlas),
            love.graphics.newQuad(96, 0, sprite_dim, sprite_dim, dice_atlas),
            love.graphics.newQuad(128, 0, sprite_dim, sprite_dim, dice_atlas),
            love.graphics.newQuad(160, 0, sprite_dim, sprite_dim, dice_atlas)            
        },
        bonus_dice = {
            love.graphics.newQuad(0, 32, sprite_dim, sprite_dim, dice_atlas),
            love.graphics.newQuad(32, 32, sprite_dim, sprite_dim, dice_atlas),
            love.graphics.newQuad(64, 32, sprite_dim, sprite_dim, dice_atlas),
            love.graphics.newQuad(96, 32, sprite_dim, sprite_dim, dice_atlas),
            love.graphics.newQuad(128, 32, sprite_dim, sprite_dim, dice_atlas),
            love.graphics.newQuad(160, 32, sprite_dim, sprite_dim, dice_atlas)
        }
    }

    map = 
    {
        {0, 0, 0, 0, 3},
        {0, 0, 0, 1, 0},
        {0, 0, 0, 0, 0},
        {0, 1, 0, 1, 0},
        {2, 0, 0, 0, 0}
    }
    enemies_stats = {
        spider = {
            sprite = love.graphics.newQuad(0, 0, enemies_dim, enemies_dim, enemies_atlas),
            life = 2,
            speed = 5,
            atk = 4,
            def = 4,
            range = 3
        },
        skelletor = {
            sprite = love.graphics.newQuad(16, 0, enemies_dim, enemies_dim, enemies_atlas),
            life = 3,
            speed = 4,
            atk = 5,
            def = 4,
            range = 4
        },
        giant = {
            sprite = love.graphics.newQuad(32, 0, enemies_dim, enemies_dim, enemies_atlas),
            life = 5,
            speed = 3,
            atk = 7,
            def = 7,
            range = 2
        },
        demon = {
            sprite = love.graphics.newQuad(48, 0, enemies_dim, enemies_dim, enemies_atlas),
            life = 5,
            speed = 5,
            atk = 5,
            def = 5,
            range = 5
        }
    }
    player = 
    {
        sprite = dice_ref.player_dice[6],
        grid_x = 1,
        grid_y = 5,
        act_x = 0,
        act_y = 4 * sprite_dim * scale_factor,
        life = 6,
        speed = 1,
        atk = 1,
        def = 1,
        range = 2
    }
    current_enemy = enemies_stats.spider

end

function love.draw()
    draw_enemy_gui()
    draw_map()
    draw_player_gui()
    draw_player()

end
function draw_player()
    love.graphics.draw(dice_atlas, player.sprite, player.act_x + map_left_padding, player.act_y + enemy_gui_height , 0, scale_factor)
end
function draw_enemy_gui()
    love.graphics.draw(enemies_atlas, current_enemy.sprite, 16, 16, 0, scale_factor)
    love.graphics.draw(icon_atlas, icon_ref.speed, (2 * sprite_dim - 25) * scale_factor, 16, 0, scale_factor)
    love.graphics.print(current_enemy.speed, (2 * sprite_dim - 8) * scale_factor, 0, 0, 5)
    love.graphics.draw(icon_atlas, icon_ref.atk, (3 * sprite_dim - 25) * scale_factor, 16, 0, scale_factor)
    love.graphics.print(current_enemy.atk, (3 * sprite_dim - 8) * scale_factor, 0, 0, 5)
    love.graphics.draw(icon_atlas, icon_ref.def, (4 * sprite_dim - 25) * scale_factor, 16, 0, scale_factor)
    love.graphics.print(current_enemy.def, (4 * sprite_dim - 8) * scale_factor, 0, 0, 5)
    love.graphics.draw(icon_atlas, icon_ref.range, (5 * sprite_dim - 25) * scale_factor, 16, 0, scale_factor)
    love.graphics.print(current_enemy.range, (5 * sprite_dim - 8) * scale_factor, 0, 0, 5)
end

function draw_map()
    local aux = love.graphics.getLineWidth()
    love.graphics.setLineWidth(3)
    love.graphics.rectangle("line", map_left_padding - 2, enemy_gui_height - 2, map_height + 4, map_height + 4)
    love.graphics.setLineWidth(aux)
    for row, rval in ipairs(map) do
        for col, cval in ipairs(rval) do
            love.graphics.draw(tile_atlas, tile_ref[cval], (row - 1) * sprite_dim * scale_factor + map_left_padding, (col - 1)  * sprite_dim * scale_factor + enemy_gui_height, 0, scale_factor)
        end
    end
end

function draw_player_gui()
end

function love.update(dt)
    if(start) then
        start = false
    else
        player_move(dt)
    end
end

function player_move(dt)
    player.act_y = player.act_y - (player.act_y - (player.grid_y - 1) * sprite_dim * scale_factor) * dt * spd
    player.act_x = player.act_x - (player.act_x - (player.grid_x - 1) * sprite_dim * scale_factor) * dt * spd
end

function love.keypressed(key)
    if (key == "down" and player.grid_y < 5) then
        player.grid_y = player.grid_y + 1
    elseif (key == "up" and player.grid_y > 1) then
        player.grid_y = player.grid_y - 1
    elseif (key == "left" and player.grid_x > 1) then
        player.grid_x = player.grid_x - 1
    elseif (key == "right" and player.grid_x < 5) then
        player.grid_x = player.grid_x + 1
    end
end