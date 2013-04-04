Facter.add(:temp) do
  confine :kernel => :windows
  setcode do
    ENV['temp']
  end
end
