local StartGameOnClick = {}

registerComponent(StartGameOnClick, "StartGameOnClick")

function StartGameOnClick:setup()
end

function StartGameOnClick:awake()
end

function StartGameOnClick:draw(x, y)
end

function StartGameOnClick:Clickable_onClickOn()
    loadLevel("game")
end

return StartGameOnClick
