class QuestionsController < ApplicationController
  before_action :find_question, only: [:destroy, :show]
  before_action :find_test, only: [:index, :create, :new]

  def index;end

  def show;end

  def new
    @question = @test.questions.new
  end

  def create
    @question = @test.questions.build(question_params)
    if @question.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @question.destroy
    redirect_to test_questions_url(@question.test)
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title)
  end

end