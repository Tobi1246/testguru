class TestPassage < ApplicationRecord
  RESPONSE_SUCCESS_RATE = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  scope :completed, -> { where(completed: true) }

  before_validation :before_validation_set_current_question

  def completed?
    current_question.nil? || time_is_over?
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    set_completed
    reset_result if time_is_over?
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

  def left_time_score
    timer_score - Time.zone.now.to_i
  end

  private

  def reset_result
    self.correct_questions = 0
    self.completed = false
  end

  def time_is_over?
    return false if self.test.timer.nil?
    left_time_score <= 0
  end

  def timer_score
    self.created_at.to_i + self.test.timer 
  end

  def set_completed
    self.completed = true if completed_test?
  end

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
