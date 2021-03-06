class TaskManagerApp < Sinatra::Base
  get '/' do
    erb :dashboard
  end

  # read
  get '/tasks' do
    @tasks = TaskManager.all
    erb :index
  end

  # create (first half)
  get '/tasks/new' do
    erb :new
  end

  # create (second half)
  post '/tasks' do
    TaskManager.create(params[:task])
    redirect '/tasks'
  end

  # read
  get '/tasks/:id' do |id|
    @task = TaskManager.find(id.to_i)
    erb :show
  end

  # update (first half)
  get '/tasks/:id/edit' do |id|
    @task = TaskManager.find(id.to_i)
    erb :edit
  end

  # update (second half)
  put '/tasks/:id' do |id|
    TaskManager.update(id.to_i, params[:task])
    redirect "/tasks/#{id}"
  end

  # delete
  delete '/tasks/:id' do |id|
    TaskManager.delete(id.to_i)
    redirect '/tasks'
  end

  not_found do
    erb :error
  end
end
