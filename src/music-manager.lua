--[[ File requires ]]--
require("common")

function newMusicManager()
  mm = {
    introSong = love.audio.newSource(MUSIC_DIR.."Azur Ramas - Time.mp3", "stream")
  }
  return mm
end
