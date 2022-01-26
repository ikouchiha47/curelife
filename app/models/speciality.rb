class Speciality < ApplicationRecord
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  before_validation :populate_slug

  def to_slug
    name.parameterize.underscore
  end

  private

    def populate_slug
      self.slug = to_slug
    end
end
