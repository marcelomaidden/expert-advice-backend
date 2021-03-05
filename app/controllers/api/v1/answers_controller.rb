module Api
  module V1
    # AnswerController handles CRUD operations
    class AnswersController < ApplicationController
      before_action :doorkeeper_authorize!, only: %i[create update]

      def index
        answers = Answer.order(:created_at)

        render json: answers
      end

      def show
        answers = Answer.where(question_id: params[:id])
        question = Question.find(params[:id])

        render json: answers, question: question
      end

      def create
        answer = Answer.new
        answer.body = answer_params[:body]
        answer.user_id = answer_params[:user]
        answer.question_id = answer_params[:question]

        if answer.save
          render json: answer, status: :ok
        else
          render json: answer, status: :unprocessable_entity,
                 serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      private

      def answer_params
        params.require(:data).require(:attributes).permit(:body, :user, :question)
      end
    end
  end
end
