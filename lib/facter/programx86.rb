Facter.add(:programx86) do
  confine :kernel => :windows
  setcode do
    ENV['programfiles(x86)']
  end
end
