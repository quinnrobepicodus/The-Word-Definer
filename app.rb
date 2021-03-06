
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('pry')
require('language_filter')
require('./lib/filter')
require('./lib/Word')

get('/') do
  WordModule::Word.clear
  erb(:home)
end

post('/word-list') do
  word = WordModule::Word.new(params.fetch("word"))
  definition = params.fetch("definition")
  if filter(word.word_name)
  else
    if filter(definition)
    else
      word.definition_list.push(definition)
    end
    word.save
  end
  erb(:home)
end

get('/word-list') do
  erb(:home)
end

get('/word/:id') do
  @word = WordModule::Word.find(params[:id])
  erb(:word)
end
post('/word/:id') do
  @word = WordModule::Word.find(params[:id])
  if filter(params.fetch("definition"))
  else
    @word.definition_list.push(params.fetch("definition"))
  end
  erb(:word)
end
