# Take selected selector out of it's parent form
jQuery.fn.outOfForm = ->
  form = @.parents('form')
  if form.length > 0
    @.insertBefore(form)
    @.hide()

# Take the selected selector with in it's first sibling form
jQuery.fn.withInForm = (placeholder) ->
  form = @.siblings('form')
  console.log form.length
  if form.length > 0
    @.insertAfter(placeholder)
    @.show()
  else
    @.show()
