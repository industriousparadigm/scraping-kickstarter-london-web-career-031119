require 'nokogiri'
require 'pry'

def create_project_hash
  page = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(page)
  elements = kickstarter.css("li.project.grid_4")

  projects = {}
  
  elements.each do |element|
    projects[element.css("h2.bbcard_name strong a").text] = {
      image_link: element.css(".projectphoto-little").attribute("src").value,
      description: element.css(".bbcard_blurb").text.strip,
      location: element.css(".location-name").text,
      percent_funded: element.css(".funded strong").text.gsub("%", "").to_i
    }
  end

  projects

end