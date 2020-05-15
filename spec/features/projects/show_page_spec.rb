require 'rails_helper'

RSpec.describe "When a user visits a project's show page", type: :feature do
    it "shows that project's name and material" do
      recycled_materials = Challenge.create({
        theme: "Recycled Material",
        project_budget: 1000
        })
      project_1 = recycled_materials.projects.create({
        name: "new project",
        material: "Recycled Material"
        })

      visit "/projects/#{project_1.id}"
      expect(page).to have_content("new project")
      expect(page).to have_content("Recycled Material")
  end
  it "shows the count of number of contestants on the project" do
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
    contestant_project_2 = ContestantProject.create({
      contestant_id: "#{contestant_2.id}",
      project_id: "#{project_1.id}"
      })

    visit "/projects/#{project_1.id}"

    expect(page).to have_content(2)
end
it "can average the age of contestants per project" do
  recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
  furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

  news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
  boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

  upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
  lit_fit = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

  jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
  gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
  kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
  erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)


  ContestantProject.create(contestant_id: jay.id, project_id: news_chic.id)
  ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
  ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)
  ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)
  ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)
  ContestantProject.create(contestant_id: erin.id, project_id: boardfit.id)

  visit("/projects/#{boardfit.id}")
  expect(page).to have_content(11.5)

end
  it "can add contestant" do
    recycled_materials = Challenge.create({
      theme: "Recycled Material",
      project_budget: 1000
      })
    project_1 = recycled_materials.projects.create({
      name: "new project",
      material: "Recycled Material"
      })
    visit("/projects/#{project_1.id}")
    fill_in :name, with: "Thomas"
    fill_in :age, with: 20
    fill_in :hometown, with: "Oklahoma"
    fill_in :years_of_experience, with: 10
    click_on("Add Contestant to Project")
    expect(current_path).to eq("/projects/#{project_1.id}")
    expect(page).to have_content(1)
    visit("/contestants")
    expect(page).to have_content("#{project_1.name}")
  end

end
