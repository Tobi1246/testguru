# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Answer.destroy_all
Question.destroy_all
TestUser.destroy_all
Test.destroy_all
Category.destroy_all
User.destroy_all

users = User.create!([{firstname: "Lion", lastname: "Di", age: 18},
                     {firstname: "Tod", lastname: "Darck", age: 48},
                     {firstname: "Joi", lastname: "Brain", age: 27}])
categorys = Category.create!([{title: "Ruby"},
             {title: "HTML"},
             {title: "SQL"}])
tests = Test.create!([{title:"Ruby", level: 1, author_id: users.at(0).id, category_id: categorys.at(0).id},
                     {title:"HTML", level: 2, author_id: users.at(1).id, category_id: categorys.at(1).id},
                     {title:"SQL", level: 2, author_id: users.at(2).id, category_id: categorys.at(2).id}])
questions = Question.create!([{title:"What is object in Ruby", test_id: tests.at(0).id},
                             {title:"What is teg <li>", test_id: tests.at(1).id},
                             {title:"How to multi merge tables", test_id: tests.at(2).id}])
Answer.create!(question_id: questions.at(0).id,
              body: "Object is the default root of all Ruby objects. 
              Object inherits from BasicObject which allows creating alternate object hierarchies.
              Methods on Object are available to all classes unless explicitly overridden.")
Answer.create!(correct: false, question_id: questions.at(0).id, body: "Class")
Answer.create!(correct: false, question_id: questions.at(0).id, body: "All except Class")
Answer.create!(question_id: questions.at(1).id, body: "List item")
Answer.create!(correct: false, question_id: questions.at(1).id, body: "link")
Answer.create!(correct: false, question_id: questions.at(1).id, body: "Create sort list")
Answer.create!(question_id: questions.at(2).id, body: "Usege JOIN  after constructions JOIN ON")
Answer.create!(correct: false, question_id: questions.at(2).id, body: "One usege JOIN and listing tables")
Answer.create!(correct: false, question_id: questions.at(2).id, body: "INNER JOIN")
TestUser.create!([{test_id: tests.at(0).id, user_id: users.at(0).id},
                  {test_id: tests.at(1).id, user_id: users.at(1).id},
                  {test_id: tests.at(2).id, user_id: users.at(1).id},
                  {test_id: tests.at(2).id, user_id: users.at(2).id}])
