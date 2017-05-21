local Sounds = {}

function Sounds.shot()
    return audio.loadSound( "assets/sounds/laser_shot.mp3" )
end

function Sounds.enemyExplosion()
    return audio.loadSound( "assets/sounds/enemy_explosion.mp3" )
end

function Sounds.gameBackground()
    return audio.loadStream( "assets/sounds/game_brackground.mp3" )
end

return Sounds
