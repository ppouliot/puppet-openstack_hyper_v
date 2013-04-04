Facter.add(:systemroot) do
  confine :kernel => :windows
  setcode do
    ENV['systemroot']
  end
end
