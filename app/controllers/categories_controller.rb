class CategoriesController < ApplicationController
  def index
    category = Category.find(params[:category_id])
    ideas = category.ideas.all
    render json: ideas
  end
  def create
    category = Category.where( name: params[:name] )
    if category.exists?
      @category = Category.find_by(name: params[:name])
      @idea = @category.ideas.build(idea_params)
      if @idea.save
        render json: { status: 201 }
      else
        render json: { status: 422 }
      end
    else
      @category = Category.new(category_params)
      if @category.save
        @idea = @category.ideas.new(idea_params)
        if @idea.save
          render json: { status: 2011 }
        else
          render json: { status: 422 }
        end
      else
        render json: { status: 422 }
      end
    end
  end

  private

  def category_params
    params.permit(:name)
  end

  def idea_params
    params.permit(:body)
  end

end
