json.languages @languages do |language|
  json.partial! 'api/languages/language', language: language
end
