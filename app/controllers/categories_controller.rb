class CategoriesController < ApplicationController
  def index
    data = []
    response = { data: data }
    if params[:category_name]
      @category = Category.find_by( name: params[:category_name] )
      if  @category.present?
        @ideas = Idea.where( category_id: @category.id )
        @ideas.each do |idea|
          category_data = {
            id: idea.id,
            category: @category.name,
            body: idea.body
          }
          data << category_data
        end
        render json: response
      else
        render json: { status: 404 }
      end
    else
      @ideas = Idea.all
      @ideas.each do |idea|
        category = Category.find(idea.category_id)
        category_data = {
          id: idea.id,
          category: category.name,
          body: idea.body
        }
        data << category_data
      end
      render json: response
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
