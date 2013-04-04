Facter.add(:psmodulepath) do
  confine :kernel => :windows
  setcode do
    ENV['psmodulepath']
  end
end
