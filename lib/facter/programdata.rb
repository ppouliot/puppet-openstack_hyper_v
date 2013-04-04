Facter.add(:tempfolder) do
  confine :kernel => :windows
  setcode do
    ENV['temp']
  end
end
