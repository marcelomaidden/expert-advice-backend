Doorkeeper::Application.destroy_all
Doorkeeper::Application.create(name: "starter_project_web", redirect_uri: "http://localhost:3000/")

User.create(email: 'marcelomaidden@test.com', password: '123456')
User.create(email: 'luana@test.com', password: '123456')

Tag.create(name: 'Rails')
Tag.create(name: 'EmberJS')
Tag.create(name: 'NightWatch')
Tag.create(name: 'Software development')

Question.create( 
  title: 'Can I create a Rails API?', 
  description: 'I am trying to create a Rails API but I need help',
  user_id: 1
)

TagQuestion.create(question_id: 1, tag_id: 1)

Question.create(
  title: 'Can I create an Ember JS app?', 
  description: 'I am trying to create an Ember JS app but I need help',
  user_id: 2
)

TagQuestion.create(question_id: 2, tag_id: 2)

Question.create(
  title: 'How can I apply for NightWatch company?', 
  description: 'I heard somewhere that I need to create and functional app',
  user_id: 2
)

TagQuestion.create(question_id: 3, tag_id: 3)
TagQuestion.create(question_id: 3, tag_id: 4)

Answer.create(user_id: 2, question_id: 1, body: 'You need to study about doorkeeper and JSON')

Answer.create(user_id: 1, question_id: 2, body: 'You need to read their documentation')

Answer.create(user_id: 2, question_id: 3, 
  body: 'I did their test assignment and you are asked to create a Rails API and
  an Ember JS frontend'
)