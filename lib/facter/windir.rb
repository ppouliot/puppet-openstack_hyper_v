Facter.add(:windir) do
  confine :kernel => :windows
  setcode do
    ENV['windir']
  end
end
