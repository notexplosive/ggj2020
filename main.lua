ALLOW_DEBUG = false
DEBUG = false

require("nx/util")
require("nx/input")
require("nx/debug-log")

-- Global classes, for better performance these should be require'd in each file as needed
Assets = require("nx/game/assets")
Vector = require("nx/vector")
Size = require("nx/size")
Rect = require("nx/rect")

local sceneLayers = require("nx/scene-layers")

require("nx/component-registry")
requireComponents("ggj/")

function love.update(dt)
    for _, scene in sceneLayers:eachInReverseDrawOrder() do
        scene:update(dt * TIMESCALE, true)
    end
end

function love.draw()
    for _, scene in sceneLayers:eachInDrawOrder() do
        scene:draw()
    end
end

local Test = require("nx/test")
Test.runComponentTests()

local Scene = require("nx/game/scene")

sceneLayers:add(Scene.new())
sceneLayers:add(Scene.new())
sceneLayers:add(Scene.new())
sceneLayers:add(Scene.new())

function titleScreen()
    backgroundScene = sceneLayers:set(1, Scene.fromPath("background"))
    gameScene = sceneLayers:set(2, Scene.fromPath("title-screen"))
    uiScene = sceneLayers:set(3, Scene.new())
    overlay = sceneLayers:set(4, Scene.new())
end

function credits()
    backgroundScene = sceneLayers:set(1, Scene.fromPath("background"))
    gameScene = sceneLayers:set(2, Scene.fromPath("credits"))
    uiScene = sceneLayers:set(3, Scene.new())
    overlay = sceneLayers:set(4, Scene.new())
end

titleScreen()

function loadLevel(levelName)
    assert(levelName)
    backgroundScene = sceneLayers:set(1, Scene.fromPath("background"))
    gameScene = sceneLayers:set(2, Scene.fromPath(levelName))
    uiScene = sceneLayers:set(3, Scene.fromPath("ui"))
    overlay = sceneLayers:set(4, Scene.new())
end

Scene:createEvent("onDisable", {})

love.graphics.setBackgroundColor(59 / 256, 20 / 256, 67 / 256, 1)

--[[ death sound
sound = Assets.sounds.spring:get()
sound:setPitch(0.05)
sound:play()
]]
musicTrack = Assets.sounds.music:get()
musicTrack:setLooping(true)
musicTrack:setVolume(0.25)
musicTrack:play()
