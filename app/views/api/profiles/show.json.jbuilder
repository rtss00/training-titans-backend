json.id @profile.id
json.description @profile.description
json.partial! 'api/profiles/requirements', requirements: @profile.requirements 
