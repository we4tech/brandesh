# Remote form doesn't require any real form element.
# Any div element with url and method attribte should work
class RemoteForm

  # Construct Remote form for the specific element
  constructor: (@jq, @el, @opt) ->
    @_log 'Constructing RemoteForm for '
    @_log @el

    @_configure()
    @_bindEvents()

  # Extract required data from remote form
  _configure: ->
    if @el._rfAttrHas('url')
      @url = @el.attr('url')
      @method = @el.attr('method') ? 'post'
      @onErrorCallback = @el.attr('onError')

      if @el._rfAttrHas('onData')
        @onDataCallback = @el.attr('onData')
      else
        alert 'Please add `onData` attribute to your remote form'
    else
      alert 'You have to add `url` attribute to your remote form element'

  # Bind required events
  _bindEvents: ->
    @_log "Binding events on remote form"
    @_log @el
    self = @

    @el.find('input').keypress (e) ->
      if e.keyCode == 13
        self._handleFormSubmit()
        false

    @el.find('.submit').click ->
      self._handleFormSubmit()


  _handleFormSubmit: ->
    @_log 'On submit event occured on '
    @_log @el
    self = @

    @_ifValid()
      .then ->
        self._submitForm()
          .then (r) ->
            func = eval(self.onDataCallback)
            func.apply(self, [self.el, r])

          .fail (r, status) ->
            func = eval(self.onErrorCallback)
            func.apply(self, [self.el, 'No such data found'])

      .fail (field_names) ->
        error_message = "Please enter value for - #{field_names.join(', ')}"

        if self.onErrorCallback?
          func = eval(self.onErrorCallback)
          func.apply(self, [self.el, error_message])
        else
          alert error_message

  # Check fields with 'validation-required' class
  # If value not found flag as validation error
  _ifValid: ->
    dfr = @jq.Deferred()
    self = @
    valid = true
    field_names = []

    $fields = @el.find('.validation-required').each ->
      $el = self.jq @
      valid = false unless $el._rfHas()
      field_names.push($el.attr('name')) unless valid

    if valid
      dfr.resolve()
    else
      dfr.reject field_names

    dfr.promise()

  _log: (msg) ->
    unless 'undefined' == typeof(console)
      console.log msg

  _submitForm: ->
    @_log 'Sending ajax request'
    @jq.ajax
      type: @method
      url: @url
      data: @_getData()
      cache: false

  _getData: ->
    self = @
    params = {}
    @el.find('input, textarea').each ->
      $el = self.jq(@)
      key = $el.attr('name')
      value = $el.val()
      params[key] = value

    params


# Setup utility functionalities
# Check if jQuery element has value or none zero length
jQuery.fn._rfHas = ->
  @.val()? && @.val().length > 0

# Check if jQuery element has attribute value or none zero length
jQuery.fn._rfAttrHas = (key) ->
  value = @.attr(key)
  value? && value.length > 0

# Create random id for element if not set
jQuery.fn._rfRandomId = ->
  (new Date().getTime() * Math.random() * 5000).toString().replace('.', '')

# Setup as jQuery plugin
jQuery.fn.remoteForm = (options) ->

  # Iterate through all remote form elements
  @.each ->

    $el = jQuery(@)
    $el.attr('id', @._rfRandomId()) unless $el._rfAttrHas('id')?
    key = "_remote_form_#{$el.attr('id')}"

    # Store RemoteForm instance through jQuery data method
    if (value = jQuery.data(@, key))?
      value
    else
      jQuery.data(@, key, new RemoteForm(jQuery, $el, options))
