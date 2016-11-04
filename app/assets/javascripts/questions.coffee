$(document).on 'turbolinks:load', ->
  $('.admin-questions #question-tags').tagit
    fieldName:   'question[tag_list]'
    singleField: true

  if gon.question_tags?
    for tag in gon.question_tags
      $('#question-tags').tagit 'createTag', tag
