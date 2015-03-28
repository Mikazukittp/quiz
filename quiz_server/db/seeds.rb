# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:

Event.create(admin_user_id: 1,name: 'テストイベント', event_date: '2015/4/31',limit_date: '2015/4/31',time_limit: 60,url: 'http://example.com',course_id:1,description: 'テスト用のイベントです。イベントの説明が入ります')

Course.create(name: 'お手軽コース', max_answerer: 20, max_question:20, price: 1000)

Choice.create(question_id: 1, sentence: '適当な質問1-1', correct_flag: true, choice_number: 1, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 1, sentence: '適当な質問1-2', correct_flag: false, choice_number: 2, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 1, sentence: '適当な質問1-2', correct_flag: false, choice_number: 3, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 1, sentence: '適当な質問1-2', correct_flag: false, choice_number: 4, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 1, sentence: '適当な質問2-1', correct_flag: false, choice_number: 1, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 1, sentence: '適当な質問2-1', correct_flag: false, choice_number: 2, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 1, sentence: '適当な質問2-1', correct_flag: false, choice_number: 3, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')
Choice.create(question_id: 1, sentence: '適当な質問2-1', correct_flag: true, choice_number: 4, answered_times: 20, image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg', thumbnail_image_url: 'http://pds.exblog.jp/pds/1/200902/16/64/e0146664_1301143.jpg')

Question.create(event_id: 1,question_number: 1,sentence: '疎通テスト用1-1',points: 100,type_id: 1)
Question.create(event_id: 1,question_number: 2,sentence: '疎通テスト用1-2',points: 100,type_id: 1)
Question.create(event_id: 2,question_number: 1,sentence: '疎通テスト用2-1',points: 100,type_id: 1)

QuestionType.create(name: '四択')