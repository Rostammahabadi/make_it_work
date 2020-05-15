class Project <ApplicationRecord
  validates_presence_of :name, :material
  belongs_to :challenge
  has_many :contestant_projects
  has_many :contestants, through: :contestant_projects
  def total_contestants
    contestants.length
  end
  def average_year_of_experience
    years = contestants.map do |contestant|
      contestant.years_of_experience
    end
    years.inject{ |sum, n| sum + n }.to_f / years.size
  end
end
