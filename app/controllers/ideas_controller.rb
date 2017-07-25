class IdeasController < ApplicationController

before_action :find_idea, only: [:edit, :destroy, :show, :update]


  def new
    @idea = Idea.new
  end

  def index
    @ideas = Idea.order(created_at: :desc)
  end

  def create

    @idea = Idea.new idea_params
    @idea.user = current_user

    if @idea.save
      # redirect_to idea_path(id: @idea.id)
      # redirect_to idea_path(@idea.id)
      redirect_to idea_path(@idea.id)

    else
      # this will render the `views/ideas/new.html.erb` to
      # show the form again (with errors). The default behaviour is to
      # render `create.html.erb`
      render :new
    end
  end

  def show

  end

  def edit
    @idea = Idea.find params[:id]
    #if the author of the idea is not the id of the current user
    #then make sure to redirect the authoritization
    if @idea.user != current_user
      redirect_to ideas_path, alert: 'Access Denied'
    end
  end

  def update
    @idea = Idea.find params[:id]
    idea_params = params.require(:idea).permit(:title, :body)

    if @idea.update idea_params
      redirect_to idea_path(@idea)
    else
      render :edit
    end

  end

  def destroy
    @idea = Idea.find params[:id]
    if @idea.user != current_user
      redirect_to ideas_path, alert: 'Access Denied'
    else
    @idea.destroy
    redirect_to ideas_path
    end
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :description)
    # The params object is avaible in all controllers and it gives you
    # access to all the data coming from a form or url params

    # Require is used to get a nested hashed with the given symbol
    # inside of the params object (in this case :idea)

    # Every input field of a form must be permitted individiually
    # otherwise rails will throw an error. This is to prevent users
    # from creating their fields
  end

  def find_idea
    @idea = Idea.find params[:id]
  end

end #
