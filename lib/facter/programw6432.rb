Facter.add(:programw6432) do
  confine :kernel => :windows
  setcode do
    ENV['programw6432']
  end
end
