# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
["Activity", "Day Care", "Home Care", "Information", "Memory", "Residential Care", "Support", "Training"].each do |category_name|
  Category.find_or_create_by(title: category_name)
end

["Day centre", "Care home", "Live in care", "Respite care", "Home care", "Carer information and support programme",
 "Personal assistant service", "Nursing care", "Information", "Support", "Palliative care"].each do |service_name|
  SubCategory.find_or_create_by(name: service_name)
end

TargetGroup.find_or_create_by(name: "I am worried about dementia")
TargetGroup.find_or_create_by(name: "I have been diagnosed with dementia")
TargetGroup.find_or_create_by(name: "I am a carer of have a family member with dementia")

# name, address, postcode, organisation_type, phone, email, website

Organisation.find_or_initialize_by(name: "The Alzheimer's Society").tap do |organisation|
  organisation.organisation_type = "Charity"
  organisation.phone = "01482 211255"
  organisation.email = "hull&eastridingservice@alzheimers.org.uk"
  organisation.website = "http://www.alzheimers.org.uk"
  organisation.postcode = "E1W 1LB"
  organisation.save!
end

Organisation.find_or_initialize_by(name: "Kingston upon Hull City Council").tap do |organisation|
  organisation.organisation_type = "Hull City Council"
  organisation.phone = "01482 300300"
  organisation.email = "info@hullcc.gov.uk"
  organisation.website = "http://www.hullcc.gov.uk"
  organisation.postcode = "HU1 2AA"
  organisation.save!
end

alzheimers = Organisation.find_by(name: "The Alzheimer's Society")
has_dementia = TargetGroup.find_by(name: "I have been diagnosed with dementia")
carer = TargetGroup.find_by(name: "I am a carer of have a family member with dementia")
activity = Category.find_by(title: "Activity")
support = SubCategory.find_by(name: "Support")
care_home = SubCategory.find_by(name: "Care home")
day_centre = SubCategory.find_by(name: "Day centre")
Resource.find_or_initialize_by(name: "Singing for the brain").tap do |resource|
  resource.summary = "Singing for the Brain provides a structured group session for people with dementia who can come along alone or with a carer"
  resource.description = <<-eos
    Singing for the Brain provides a structured group session for people with dementia who can come along alone or with a carer.
    The service is designed around the principles of music therapy and singing.
    Singing for the Brain sessions are planned to encourage sociability, peer support, engagement and active participation.
    The groups run fortnightly in venues across the East Riding. Sessions are held fortnightly on a Friday 1.30 – 3pm.
  eos
  resource.organisation = alzheimers
  resource.target_groups = [has_dementia, carer]
  resource.url = "http://www.dementiaeastriding.org.uk/singing-for-the-brain/"
  resource.address = "Middle Lounge, Willerby Methodist Church, Carr Lane, Willerby"
  resource.postcode = "HU10 6JP"
  resource.categories = [activity]
  resource.services = [support]
  resource.save!
end
Resource.find_or_initialize_by(name: "Befriending service").tap do |resource|
  resource.summary = "Volunteers who help those with moderate dementia keep active"
  resource.description = <<-eos
    Volunteers who help those with moderate dementia keep active.
    Befrienders will regularly spent two to three hours a week or fortnight with the person with dementia.
    Activities typically include gardening, cooking or baking, shopping, walking a dog etc.
  eos
  resource.organisation = alzheimers
  resource.target_groups = [has_dementia]
  resource.url = "http://www.dementiaeastriding.org.uk/befriending/"
  resource.address = "Suite D, Annie Reed Court, Annie Reed Road, Beverley, East Riding of Yorkshire"
  resource.postcode = "HU17 0LF"
  resource.categories = [activity]
  resource.services = [support]
  resource.save!
end
hull_cc = Organisation.find_by(name: "Kingston upon Hull City Council")
day_care = Category.find_by(title: "Day Care")
Resource.find_or_initialize_by(name: "Highfield Resource Centre").tap do |resource|
  resource.summary = "The Highfield resource centre provides services during the day for older people"
  resource.description = <<-eos
    The Highfield resource centre provides services during the day for older people in parts of north and east Hull and the Bransholme and Sutton area.
    Also acts as a residential home.
  eos
  resource.organisation = hull_cc
  resource.target_groups = [has_dementia, carer]
  resource.main_phone = "01482 826199"
  resource.secondary_phone = "01482 824506"
  resource.url = "http://www.dementiaeastriding.org.uk/befriending/"
  resource.address = "Highfield Resource Centre, Wawne Road, Sutton-on-Hull, Humberside"
  resource.postcode = "HU7 4YG"
  resource.categories = [day_care]
  resource.services = [day_centre, care_home]
  resource.save!
end

Resource.find_or_initialize_by(name: "Nicholson House").tap do |resource|
  resource.summary = "Nicholson house provides day services for older people in East Hull"
  resource.description = <<-eos
    Nicholson house provides day care services for older people in East Hull. It is a modern, purpose built care home and day centre which provides services for
    people with a physical disability. Accommodates 29 residents in 29 single rooms.
  eos
  resource.organisation = hull_cc
  resource.target_groups = [has_dementia, carer]
  resource.main_phone = "01482 709443"
  resource.url = "http://www.hullcc.gov.uk/portal/page?_pageid=221,72847&_dad=portal&_schema=PORTAL"
  resource.address = "Nicholson House, 97 Mirfield Grove, Sutton Way, Hull"
  resource.postcode = "HU9 4QR"
  resource.categories = [day_care]
  resource.services = [day_centre, care_home]
  resource.save!
end
