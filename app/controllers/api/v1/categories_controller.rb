module Api
  module V1
    class CategoriesController < ApplicationController
      def index
        data = []
        if params[:category_name]
          @category = Category.find_by(name: params[:category_name])
          if @category.present?
            @ideas = Idea.where(category_id: @category.id)
            @ideas.each do |idea|
              category_data = {
                id: idea.id,
                category: @category.name,
                body: idea.body
              }
              data << category_data
            end
            render json: { data: data }
          else
            render status: 404, json: { status: 404, message: 'Not Found' }
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
          render json: { data: data }
        end
      end

      def create
        @category = Category.find_by(name: params[:category_name])
        if @category.present? && params[:body].present?
          @idea = @category.ideas.new(idea_params)
          if @idea.save
            render status: 201, json: { status: 201, message: 'Created' }
          else
            render status: 422, json: { status: 422, message: 'Unprocessable Entity' }
          end
        elsif params[:body].present?
          params[:name] = params[:category_name]
          @category = Category.new(category_params)
          if @category.save
            @idea = @category.ideas.new(idea_params)
            if @idea.save
              render status: 201, json: { status: 201, message: 'Created' }
            else
              render status: 422, json: { status: 422, message: 'Unprocessable Entity' }
            end
          else
            render status: 422, json: { status: 422, message: 'Unprocessable Entity' }
          end
        else
          render status: 422, json: { status: 422, message: 'Unprocessable Entity' }
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
  end
end
