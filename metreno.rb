class Statistic
  attr_accessor :people

  def initialize(*people)
    @people = people
  end

  def stats
    grouped_questions_with_answers.each do |q, a|
      puts "[Question] #{q}"
      puts count_answers(a, 'Yes')
      puts count_answers(a, 'No')
    end
  end

  def results
    people.each do |person|
      puts "ANSWERS FOR: #{person.name}"
      person.questionnaire.questions.each do |q|
        puts "[Q] #{q.text}"
        puts "[A] #{q.selected_answer}"
      end
    end
  end

  private

  def count_answers(answers, answer)
    "#{answer}:  #{answers.count(answer)} - #{100 * answers.count(answer) / answers.length}%"
  end

  def grouped_questions_with_answers
    questions_with_answers = people.map { |p| p.questionnaire.questions }.flatten.map(&:for_statistics)
    result = {}
    questions_with_answers.each do |q|
      if result[q[0]]
        result[q[0]] << q[1]
      else
        result[q[0]] = [q[1]]
      end
    end
    result
  end
end

class Question
  attr_accessor :text, :answers, :selected_answer

  def initialize(text, answers)
    @text = text
    @answers = answers
    @selected_answer = nil
  end

  def select(answer)
    if answers.include?(answer)
      @selected_answer = answer
      puts "selected: #{answer}"
    else
      puts 'wrong answer'
    end
  end

  def for_statistics
    [text, selected_answer]
  end
end

class Questionnaire
  attr_accessor :questions

  def initialize(*questions)
    @questions = questions
  end
end

class Person < Struct.new(:name, :questionnaire)
end

question_1 = Question.new("Are you married?", ["Yes", "No"])
question_2 = Question.new("Do you have a job?", ["Yes", "No"])
question_3 = Question.new("Are you going to the gym?", ["Yes", "No"])
questionnaire_1 = Questionnaire.new(question_1, question_2, question_3)

question_4 = Question.new("Are you married?", ["Yes", "No"])
question_5 = Question.new("Do you have a job?", ["Yes", "No"])
question_6 = Question.new("Are you going to the gym?", ["Yes", "No"])
questionnaire_2 = Questionnaire.new(question_4, question_5, question_6)

question_7 = Question.new("Are you married?", ["Yes", "No"])
question_8 = Question.new("Do you have a job?", ["Yes", "No"])
question_9 = Question.new("Are you going to the gym?", ["Yes", "No"])
questionnaire_3 = Questionnaire.new(question_7, question_8, question_9)

question_A = Question.new("Are you married?", ["Yes", "No"])
question_B = Question.new("Do you have a job?", ["Yes", "No"])
question_C = Question.new("Are you going to the gym?", ["Yes", "No"])
questionnaire_4 = Questionnaire.new(question_A, question_B, question_C)

person_1 = Person.new('Irek', questionnaire_1)
person_1.questionnaire.questions[0].select("Yes")
person_1.questionnaire.questions[1].select("Yes")
person_1.questionnaire.questions[2].select("Yes")

person_2 = Person.new('Moni', questionnaire_2)
person_2.questionnaire.questions[0].select("Yes")
person_2.questionnaire.questions[1].select("No")
person_2.questionnaire.questions[2].select("No")

person_3 = Person.new('Mati', questionnaire_3)
person_3.questionnaire.questions[0].select("No")
person_3.questionnaire.questions[1].select("Yes")
person_3.questionnaire.questions[2].select("No")

person_4 = Person.new('Iza', questionnaire_4)
person_4.questionnaire.questions[0].select("Yes")
person_4.questionnaire.questions[1].select("Yes")
person_4.questionnaire.questions[2].select("No")

stats = Statistic.new(person_1, person_2, person_3, person_4)
puts '----------------------------------'
stats.stats
puts '----------------------------------'
stats.results
