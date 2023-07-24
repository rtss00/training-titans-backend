json.technologies @technologies do |technology|
  json.partial! 'api/technologies/technology', technology: technology
end
