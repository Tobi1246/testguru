class TestPassage < ApplicationRecord

  RESPONSE_SUCCESS_RATE = 85.freeze

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_current_question

  def completed?
    current_question.nil?
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save!
  end

  def completed_test?
    point_question >= RESPONSE_SUCCESS_RATE
  end

  def current_question_number
    count_questions - test.questions.order(:id).where('id > ?', current_question.id).count
  end

  def point_question
    (self.correct_questions * 100) / count_questions
  end

  private

  def before_validation_set_current_question
    return self.current_question = test.questions.first if current_question.nil?

    self.current_question = test.questions.order(:id).where('id > ?', current_question.id).first
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.to_a.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct 
  end

  def count_questions
    self.test.questions.count
  end

end