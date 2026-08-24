class Team < ApplicationRecord
  has_many :table_prediction_entries, dependent: :restrict_with_exception

  validates :name, presence: true, uniqueness: true

  def self.sync_from_matches(season)
    Match.where(season: season).find_each do |match|
      [ [ match.home, match.home_crest ], [ match.away, match.away_crest ] ].each do |name, crest_url|
        sync(name, crest_url)
      end
    end
  end

  def self.sync(name, crest_url)
    return if name.blank?

    team = find_or_initialize_by(name: name)
    team.crest_url = crest_url if crest_url.present?
    team.save! if team.new_record? || team.changed?
    team
  end
end
