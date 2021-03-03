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

      end

      private

      def question_params
        puts params
        params.require(:question).permit(:title, :description, :user_id, :tags)
      end
    end
  end
end
