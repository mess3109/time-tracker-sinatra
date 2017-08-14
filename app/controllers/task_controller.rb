class TaskController < ApplicationController

  #Show tasks for current user
  get '/tasks' do
    if logged_in?
      erb :'tasks/index'
    else
      redirect '/login'
    end
  end

  #Create task
  get '/tasks/new' do
    if logged_in?
      erb :'tasks/new'
    else
      redirect '/login'
    end
  end

  post '/tasks' do
    task = Task.create(params[:task])
    task.user = current_user
    current_user.tags << task.tag if !current_user.tags.include?(task.tag)
    if task.save
      flash[:message]= "New task created!"
      redirect "/tasks"
    else
      flash[:message] = "Required field missing"
      redirect "/tasks/new"
    end
  end

  #Read task
  get '/tasks/:id' do
    if logged_in?
      @task = Task.find_by_id(params[:id])
      if @task.user = current_user
        erb :'/tasks/show'
      else
        redirect "/tasks"
      end
    else
      redirect "/"
    end
  end

  #Update task
  get '/tasks/:id/edit' do
    if logged_in?
      @task = Task.find_by_id(params[:id])
      if current_user == @task.user
        erb :'/tasks/edit'
      else
        flash[:message] = "You cannot edit that task"
        redirect "/tasks"
      end
    else
      redirect "/"
    end
  end

  patch '/tasks/:id' do
    task = Task.find_by_id(params[:id])
    task.update(params[:task])
    current_user.tags << task.tag if !current_user.tags.include?(task.tag)
    if task.save
      flash[:message]= "Task updated!"
      redirect "/tasks"
    else
      flash[:message] = "Required field missing"
      redirect "/tasks/edit"
    end
  end

  #Delete task
  get '/tasks/:id/delete' do
    if logged_in?
      @task = Task.find_by_id(params[:id])
      if current_user == @task.user
        erb :'/tasks/delete'
      else
        flash[:message] = "You cannot delete that task"
        redirect "/tasks"
      end
    else
      redirect "/"
    end
  end

  delete '/tasks/:id/delete' do
    @task = Task.find(params[:id])
    @task.delete
    flash[:message]= "Task successfully deleted"
    redirect "/tasks"
  end

end
