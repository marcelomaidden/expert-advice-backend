module Api
  module V1
    # QuestionsController is used on CRUD operations on questions and returns a json response
    class QuestionsController < ApplicationController
      WillPaginate.per_page = 5
      before_action :doorkeeper_authorize!, only: %i[create update]
      before_action :set_question, only: %i[show update destroy]
      before_action :check_user, only: %i[update destroy]

      def index
        if params[:page]
          if params[:tag]
            questions = Tag.find(params[:tag])
            questions = questions.questions.paginate(page: params[:page])
          else
            questions = Question.paginate(page: params[:page])
          end
          questions = questions.where(user_id: params[:user]) if params[:user]
          questions = questions.order(:created_at)
        else
          questions = Question.order(:created_at)
        end

        paginate json: questions
      end

      def show
        render json: @question, status: :ok
      rescue StandardError
        render json: { error: 'Question not found' }
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

        tags.each do |tag|
          name = tag.strip.downcase.capitalize
          t = Tag.find_by(name: name)
          t ||= Tag.create(name: name)
          TagQuestion.create(question_id: question.id, tag_id: t.id)
        end unless tags.blank?
      end

      def destroy
        tag_question = TagQuestion.where(question_id: @question.id)
        tag_question.delete_all
        answers = Answer.where(question_id: @question.id)
        answers.delete_all
        if @question.delete
          render json: @question
        else
          render json: @question,
                 status: :unprocessable_entity,
                 serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      def update
        @question.title = question_params[:title]
        @question.description = question_params[:description]

        if @question.save
          render json: @question
        else
          render json: @question,
                 status: :unprocessable_entity,
                 serializer: ActiveModel::Serializer::ErrorSerializer
        end

        tags = question_params[:tags].split(',')

        tag_question = TagQuestion.where(question_id: @question.id)
        tag_question.delete_all

        tags.each do |tag|
          name = tag.strip.downcase.capitalize
          t = Tag.find_by(name: name)
          t ||= Tag.create(name: name)
          TagQuestion.create(question_id: @question.id, tag_id: t.id)
        end unless tags.blank?
      end

      private

      def question_params
        params[:data][:attributes].delete('answers')
        params.require(:data).require(:attributes).permit(:title, :description, :tags, :pages, :user)
      end

      def set_question
        @question = Question.find(params[:id])
      end

      def check_user
        user = nil
        user ||= User.find(doorkeeper_token[:resource_owner_id]) if doorkeeper_token
        render json: @question,
               status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer unless @question.user.id == user.id
      end
    end
  end
end
