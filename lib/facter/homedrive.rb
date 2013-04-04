Facter.add(:homedrive) do
  confine :kernel => :windows
  setcode do
    ENV['homedrive']
  end
end
