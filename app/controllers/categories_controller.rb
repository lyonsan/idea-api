class CategoriesController < ApplicationController
  def index
    if params[:category_name]
      @category = Category.find_by( name: params[:category_name] )
      if  @category.present?
        @ideas = Idea.where( category_id: @category.id )
        render json: @ideas
      else
        render json: { status: 422 }
      end
    else
      @ideas = Idea.all
      render json: @ideas
    end
  end
  def create
    @category = Category.find_by( name: params[:category_name] )
    if @category.present? && params[:body].present?
      @category = Category.find_by(name: params[:category_name])
      @idea = @category.ideas.build(idea_params)
      if @idea.save
        render json: { status: 201 }
      else
        render json: { status: 422 }
      end
    elsif params[:body].present?
      params[:name] = params[:category_name]
      @category = Category.new(category_params)
      if @category.save
        @idea = @category.ideas.new(idea_params)
        if @idea.save
          render json: { status: 201 }
        else
          render json: { status: 422 }
        end
      else
        render json: { status: 422 }
      end
    else
      render json: { status: 422 }
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
