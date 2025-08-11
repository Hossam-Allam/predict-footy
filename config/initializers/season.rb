module Season
  def self.current
    (ENV["CURRENT_SEASON"] || 2026).to_i
  end
end
