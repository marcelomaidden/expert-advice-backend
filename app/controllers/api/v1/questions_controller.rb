module Api
  module V1
    class QuestionsController < ApplicationController
      before_action :doorkeeper_authorize!, only: [:create, :update]

      def index
        questions=Question.order(:created_at)

        paginate json: questions, per_page: 10
      end

      def show
        question = Question.find(params[:id])

        render json: question, status: :ok
        
        rescue
          render json: {error: "Question not found"}
        
      end

      def create
        question = Question.new
        question.title = question_params[:title]
        question.description = question_params[:description]
        question.user_id = question_params[:user]

        if question.save
          render json: question
        else
          render json: question,
                             status: :unprocessable_entity,
                             serializer: ActiveModel::Serializer::ErrorSerializer
        end
        tags = question_params[:tags].split(',')
      end

      private

      def question_params
        params.require(:data).require(:attributes).permit(:title, :description, :user, :tags)
      end
    end
  end
end
