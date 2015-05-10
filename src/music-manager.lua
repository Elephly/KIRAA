--[[ File requires ]]--
require("common")

musicManager = {}

function newMusicManager()
  mm = {
    --Songs
    gameSong1 = love.audio.newSource(MUSIC_DIR.."Azur Ramas - Time.mp3", "stream"),
    bossSong1 = love.audio.newSource(MUSIC_DIR.."Doctor Vox - Frontier.mp3", "stream"),
    gameSong2 = love.audio.newSource(MUSIC_DIR.."Coyote Kisses - Ferrari.mp3", "stream"),
    --bossSong2 = love.audio.newSource(MUSIC_DIR..".mp3", "stream"),
    gameSong3 = love.audio.newSource(MUSIC_DIR.."K-391 - Summertime.mp3", "stream"),
    bossSong3 = love.audio.newSource(MUSIC_DIR.."K-391 - Don't Stop.mp3", "stream"),
    gameOverSong = love.audio.newSource(MUSIC_DIR.."K-391 - Skyline.mp3", "stream"),

    --Properties
    currentSong,
    nextSong,
    fadeOutTime,
    fadeInTime,
    elapsedTransitionTime,

    --Methods
    playSong = musicManager.playSong,
    update = musicManager.update,
  }
  return mm
end

function musicManager:playSong(source, looping, fadeOutTime, fadeInTime)
  self.nextSong = source
  self.nextSong:setLooping(looping)
  self.fadeOutTime = fadeOutTime
  self.fadeInTime = fadeInTime
  self.elapsedTransitionTime = 0
end

function musicManager:update(dt)
  self.elapsedTransitionTime = self.elapsedTransitionTime + dt
  if self.nextSong then
    if not self.nextSong:isPlaying() then
      self.nextSong:play()
    end
    if self.elapsedTransitionTime < self.fadeInTime then
      self.nextSong:setVolume(self.elapsedTransitionTime / self.fadeInTime)
    else
      if self.currentSong then
        self.nextSong:setVolume(1)
        if self.elapsedTransitionTime >= self.fadeOutTime then
          self.nextSong = nil
        end
      end
    end
  end
  if self.currentSong then
    if self.nextSong then
      if self.elapsedTransitionTime < self.fadeOutTime then
        self.currentSong:setVolume((self.fadeOutTime - self.elapsedTransitionTime) /
          self.fadeOutTime)
      else
        self.currentSong:stop()
        self.currentSong = nil
      end
    end
  else
    if self.nextSong and self.elapsedTransitionTime >= self.fadeInTime then
      self.currentSong = self.nextSong
    end
  end
end
