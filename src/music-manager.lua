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
    fadeOutDelay,
    fadeInTime,
    fadeInDelay,
    elapsedTransitionTime,

    --Methods
    isPlaying = musicManager.isPlaying,
    playSong = musicManager.playSong,
    update = musicManager.update,
  }
  return mm
end

function musicManager:playSong(source, looping, fadeOutTime, fadeOutDelay, fadeInTime, fadeInDelay)
  self.nextSong = source
  self.nextSong:setLooping(looping)
  self.fadeOutTime = fadeOutTime
  self.fadeOutDelay = fadeOutDelay
  self.fadeInTime = fadeInTime
  self.fadeInDelay = fadeInDelay
  self.elapsedTransitionTime = 0
end

function musicManager:update(dt)
  self.elapsedTransitionTime = self.elapsedTransitionTime + dt
  if self.nextSong and self.elapsedTransitionTime >= self.fadeInDelay then
    if not self.nextSong:isPlaying() then
      self.nextSong:play()
    end
    if (self.elapsedTransitionTime - self.fadeInDelay) < self.fadeInTime then
      self.nextSong:setVolume((self.elapsedTransitionTime - self.fadeInDelay) /
        self.fadeInTime)
    else
      self.nextSong:setVolume(1)
      if self.currentSong == self.nextSong then
        self.nextSong = nil
      end
    end
  end
  if self.currentSong and self.elapsedTransitionTime >= self.fadeOutDelay then
    if self.nextSong then
      if (self.elapsedTransitionTime - self.fadeOutDelay) < self.fadeOutTime then
        self.currentSong:setVolume((self.fadeOutTime - (self.elapsedTransitionTime -
          self.fadeOutDelay)) / self.fadeOutTime)
      else
        self.currentSong:stop()
        self.currentSong = nil
      end
    end
  else
    if self.nextSong and (self.elapsedTransitionTime - self.fadeInDelay) >=
      self.fadeInTime and (self.elapsedTransitionTime - self.fadeOutDelay) >=
      self.fadeOutTime then
      self.currentSong = self.nextSong
    end
  end
end

function musicManager:isPlaying(source)
  return self.currentSong == source or self.nextSong == source
end
