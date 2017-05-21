local ParticleDesigner = {}
local pex = require( "src.util.pex" )

function ParticleDesigner.newEmitter( filePex, fileTexturePng )

   local emitterParams = pex.load( filePex, fileTexturePng )
   local emitter = display.newEmitter( emitterParams )

   return emitter
end

return ParticleDesigner
