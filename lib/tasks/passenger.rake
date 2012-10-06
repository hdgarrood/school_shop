require 'fileutils'

namespace :passenger do
  desc "takes the app down"
  task :stop do
    FileUtils.touch 'tmp/is-unavailable'
  end

  desc "undo passenger:stop"
  task :start do
    FileUtils.remove 'tmp/is-unavailable'
  end
end
