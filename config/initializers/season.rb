module Season
  def self.current
    (ENV["CURRENT_SEASON"] || 2027).to_i
  end
end
