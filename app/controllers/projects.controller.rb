class ProjectsController < ApplicationController
    
    get '/projects' do
        if logged_in?
          @projects = Project.all
           erb :'projects/projects'
        else
          redirect to '/login'
        end
      end
    
      get '/projects/new' do
        if logged_in?
          erb :'projects/create_project'
        else
          redirect to '/login'
        end
      end
    
      post '/projects' do
        if logged_in?
            @project = current_user.projects.build(content: params[:content], title: params[:title], created_at: params[:created_at])
             if @project.save
              
              redirect to "/projects/#{@project.id}"
            else
              redirect to "/projects/new"
            end
          
        else
          redirect to '/login'
        end
      end
    
      get '/projects/:id' do
        if logged_in?
          if @project = Project.find_by_id(params[:id])
            erb :'projects/show_project'
          else 
            redirect to '/projects'
          end
        else
          redirect to '/login'
        end
      end
    
      get '/projects/:id/edit' do
        if logged_in?
          @project = Project.find_by_id(params[:id])
          if @project && @project.user == current_user
            erb :'projects/edit_project'
          else
            redirect to '/projects'
          end
        else
          redirect to '/login'
        end
      end
    
      patch '/projects/:id' do
        if logged_in?
          @project = Project.find_by_id(params[:id])
            if @project && @project.user == current_user
              if @project.update(content: params[:content], title: params[:title])
                redirect to "/projects/#{@project.id}"
              else
                redirect to "/projects/#{@project.id}/edit"
              end
            else
              redirect to '/projects'
            end
          
        else
          redirect to '/login'
        end
      end
    
      delete '/projects/:id/delete' do
        if logged_in?
          @project = Project.find_by_id(params[:id])
          if @project && @project.user == current_user
            @project.delete
            
          end
          redirect to '/projects'
        else
          redirect to '/login'
        end
      end
    end