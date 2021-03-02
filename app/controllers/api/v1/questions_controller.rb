module Api
  module V1
    class QuestionsController < ApplicationController
      def index
        questions=Question.order(:created_at)

        paginate json: questions, per_page: 1
      end
    end
  end
end
