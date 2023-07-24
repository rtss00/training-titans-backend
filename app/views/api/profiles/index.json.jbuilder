json.profiles @profiles do |profile|
  json.id profile.id
  json.description profile.description
  json.area profile.area
  json.name profile.name
  json.language profile.language
  json.partial! 'api/profiles/requirements', requirements: profile.requirements
end
