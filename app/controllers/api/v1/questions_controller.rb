module Api
  module V1
    class QuestionsController < ApplicationController
      WillPaginate.per_page=5
      before_action :doorkeeper_authorize!, only: [:create, :update]
      before_action :set_question, only: [:show, :update, :destroy]
      before_action :check_user, only: [:update, :destroy]

      def index
        if params[:page]
          questions=Question.paginate(page: params[:page]).order(:created_at)
        else
          questions=Question.order(:created_at)
        end

        #paginate json: questions, meta: pagination_meta(questions)
        paginate json: questions
      end

      def show
        render json: @question, status: :ok
        
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

        if !tags.blank?
          tags.each do |tag|
            name=tag.strip.downcase.capitalize
            t = Tag.find_by(name: name)
            t = Tag.create(name: name) unless  t
            TagQuestion.create(question_id: question.id, tag_id: t.id)
          end
        end
      end

      def destroy
        tagQuestion = TagQuestion.where(question_id: @question.id)
        tagQuestion.delete_all
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

        tagQuestion = TagQuestion.where(question_id: @question.id)
        tagQuestion.delete_all

        if !tags.blank?
          tags.each do |tag|
            name=tag.strip.downcase.capitalize
            t = Tag.find_by(name: name)
            t = Tag.create(name: name) unless  t
            TagQuestion.create(question_id: @question.id, tag_id: t.id)
          end
        end
      end

      private
      # def pagination_meta(object)
      #   {
      #     current_page: object.current_page,
      #     next_page: object.next_page,
      #     prev_page: object.previous_page,
      #     total_pages: object.total_pages,
      #     total_count: object.total_entries,
      #     per_page: object.per_page
      #   }
      # end
      def question_params
        params.require(:data).require(:attributes).permit(:title, :description, :user, :tags, :answers, :pages)
      end

      def set_question
        @question = Question.find(params[:id])
      end

      def check_user
        user = nil
        user ||= User.find(doorkeeper_token[:resource_owner_id]) if doorkeeper_token
        render json: @question,
        status: :unprocessable_entity,
        serializer: ActiveModel::Serializer::ErrorSerializer unless @question.user.id == user.id
      end
    end
  end
end
