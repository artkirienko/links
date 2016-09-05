App.alert = App.cable.subscriptions.create "AlertChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    @appendLine(data)

  appendLine: (data) ->
    html = @createLine(data)
    $("#messages").append(html)

  createLine: (data) ->
    """
    <div class="message">
      <span class="status">#{data['status']}</span>
      <span class="response-code">#{data['response_code']}</span>
      <span class="link"><a href="#{data['link']}">#{data['link']}</a></span>
      <span class="timestamp">#{data['timestamp']}</span>
    </div>
    """
