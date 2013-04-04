Facter.add(:public) do
  confine :kernel => :windows
  setcode do
    ENV['public']
  end
end
