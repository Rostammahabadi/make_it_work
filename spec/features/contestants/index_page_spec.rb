require 'rails_helper'

RSpec.describe "When a user visits the contestants index page", type: :feature do
    it "shows a list of names of all contestants" do
      recycled_materials = Challenge.create({
        theme: "Recycled Material",
        project_budget: 1000
        })
      project_1 = recycled_materials.projects.create({
        name: "new project",
        material: "Recycled Material"
        })
      contestant_1 = Contestant.create({
        name: "Kentaro Kameyama",
        age: 34,
        hometown: "Sterling",
        years_of_experience: 12
        })
      contestant_2 = Contestant.create({
        name: "Jay McCarroll",
        age: 34,
        hometown: "Sterling",
        years_of_experience: 12
        })
      contestant_project_1 = ContestantProject.create({
        contestant_id: "#{contestant_1.id}",
        project_id: "#{project_1.id}"
        })

      visit "/contestants"

      expect(page).to have_content("Kentaro Kameyama")
      expect(page).to have_content("Jay McCarroll")
      expect(page).to have_content("new project")
  end

end
