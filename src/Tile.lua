--[[
    GD50
    Match-3 Remake

    -- Tile Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The individual tiles that make up our game board. Each Tile can have a
    color and a variety, with the varietes adding extra points to the matches.
]]

Tile = Class{}

function Tile:init(x, y, color, variety)
    
    -- board positions
    self.gridX = x
    self.gridY = y

    -- coordinate positions
    self.x = (self.gridX - 1) * 32
    self.y = (self.gridY - 1) * 32

    -- tile appearance/points
    self.color = color
    self.variety = variety

    -- random shinty tile
    self.isShiny = math.random(1, 1000) < 100
    if(self.isShiny ) then
        self.shineAlpha = 0
        Timer.every(2, function()
                Timer.tween(0.75, {
                    [self] = {shineAlpha = 100}
                }):finish(function()
                    Timer.tween(0.75,{
                        [self] = {shineAlpha = 0}
                    })
                end)
        end )
    end

end

function Tile:render(x, y)
    
    -- draw shadow
    love.graphics.setColor(34, 32, 52, 255)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x + 2, self.y + y + 2)

    -- draw tile itself
    love.graphics.setColor(220, 220, 220, 235)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x, self.y + y)

    if(self.isShiny) then
        love.graphics.setColor(255, 255, 100, self.shineAlpha)
        love.graphics.rectangle('fill', self.x + x, self.y + y, 32, 32, 8)
        love.graphics.rectangle('fill', self.x + x + 2, self.y + y + 2, 32, 32, 8)
    end

end