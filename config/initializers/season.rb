module Season
  def self.current
    (ENV["CURRENT_SEASON"] || 2025).to_i
  end
end
