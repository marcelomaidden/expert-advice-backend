module Api
  module V1
    class QuestionsController < ApplicationController
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
    end
  end
end
