# Default User For Devise
AdminUser.create(email: 'sample@example.com', password: '123456a-', confirmation_token: nil, confirmed_at: '2015-04-18 05:31:21')

Event.create(admin_user_id: 1,name: 'テストイベント', event_date: '2015/4/31',limit_date: '2015/4/31',time_limit: 60,url: '',course_id:1,description: 'テスト用のイベントです。イベントの説明が入ります')
Event.create(admin_user_id: 1,name: 'テストイベント2', event_date: '2015/4/31',limit_date: '2015/4/31',time_limit: 60,url: '',course_id:1,description: 'テスト用のイベントです。イベントの説明が入ります')

Question.create(event_id: 1,question_number: 1,sentence: '疎通テスト用1-1',points: 100,type_id: 1)
Question.create(event_id: 1,question_number: 2,sentence: '疎通テスト用1-2',points: 100,type_id: 1)
Question.create(event_id: 1,question_number: 3,sentence: '疎通テスト用1-3',points: 100,type_id: 1)
Question.create(event_id: 1,question_number: 4,sentence: '疎通テスト用1-4',points: 100,type_id: 1)
Question.create(event_id: 1,question_number: 5,sentence: '疎通テスト用1-5',points: 100,type_id: 1)
Question.create(event_id: 2,question_number: 1,sentence: '疎通テスト用2-1',points: 100,type_id: 1)

Course.create(name: 'お手軽コース', max_answerer: 20, max_question:20, price: 1000)

Choice.create(question_id: 1, sentence: '適当な質問1-1', correct_flag: true, choice_number: 1, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 1, sentence: '適当な質問1-2', correct_flag: false, choice_number: 2, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 1, sentence: '適当な質問1-3', correct_flag: false, choice_number: 3, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 1, sentence: '適当な質問1-4', correct_flag: false, choice_number: 4, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 2, sentence: '適当な質問2-1', correct_flag: false, choice_number: 1, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 2, sentence: '適当な質問2-2', correct_flag: false, choice_number: 2, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 2, sentence: '適当な質問2-3', correct_flag: false, choice_number: 3, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 2, sentence: '適当な質問2-4', correct_flag: true, choice_number: 4, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 3, sentence: '適当な質問3-1', correct_flag: true, choice_number: 1, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 3, sentence: '適当な質問3-2', correct_flag: false, choice_number: 2, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 3, sentence: '適当な質問3-3', correct_flag: false, choice_number: 3, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 3, sentence: '適当な質問3-4', correct_flag: false, choice_number: 4, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 4, sentence: '適当な質問4-1', correct_flag: false, choice_number: 1, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 4, sentence: '適当な質問4-2', correct_flag: false, choice_number: 2, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 4, sentence: '適当な質問4-3', correct_flag: false, choice_number: 3, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 4, sentence: '適当な質問4-4', correct_flag: true, choice_number: 4, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 5, sentence: '適当な質問5-1', correct_flag: true, choice_number: 1, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 5, sentence: '適当な質問5-2', correct_flag: false, choice_number: 2, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 5, sentence: '適当な質問5-3', correct_flag: false, choice_number: 3, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 5, sentence: '適当な質問5-4', correct_flag: false, choice_number: 4, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 6, sentence: '適当な質問6-1', correct_flag: false, choice_number: 1, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 6, sentence: '適当な質問6-2', correct_flag: false, choice_number: 2, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 6, sentence: '適当な質問6-3', correct_flag: false, choice_number: 3, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 6, sentence: '適当な質問6-4', correct_flag: true, choice_number: 4, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')

Answerer.create(event_id: 1, name: 'サンプル解答者')
Answerer.create(event_id: 1, name: 'サンプル解答者2')
Answerer.create(event_id: 1, name: 'サンプル解答者3')

Answer.create(question_id: 1,answerer_id: 1, answer_time: 40, choice_question_number: 1, is_correct: true)
Answer.create(question_id: 2,answerer_id: 1, answer_time: 40, choice_question_number: 1, is_correct: false)
Answer.create(question_id: 3,answerer_id: 1, answer_time: 40, choice_question_number: 1, is_correct: true)
Answer.create(question_id: 1,answerer_id: 2, answer_time: 40, choice_question_number: 2, is_correct: false)
Answer.create(question_id: 2,answerer_id: 2, answer_time: 40, choice_question_number: 1, is_correct: false)
Answer.create(question_id: 3,answerer_id: 2, answer_time: 40, choice_question_number: 1, is_correct: true)
Answer.create(question_id: 1,answerer_id: 2, answer_time: 70, choice_question_number: 1, is_correct: false)
Answer.create(question_id: 2,answerer_id: 2, answer_time: 40, choice_question_number: 1, is_correct: false)
Answer.create(question_id: 3,answerer_id: 2, answer_time: 40, choice_question_number: 1, is_correct: true)

QuestionType.create(name: '四択')
