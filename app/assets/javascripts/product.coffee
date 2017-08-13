$(document).on 'turbolinks:load', ->
  $('[type=file]').fileupload
    add: (e, data) =>
      data.progressBar = $('<div class="progress" style="width: 300px"><div class="progress-bar"></div></div>').insertAfter(".form-group")
      options = {
        extension: data.files[0].name.match(/(\.\w+)?$/)[0],
        _: Date.now(),
      }
      $.getJSON '/images/cache/presign', options, (result) =>
        data.formData = result['fields']
        data.url = result['url']
        data.paramName = 'file'
        data.submit()
    progress: (e, data) =>
      progress = parseInt(data.loaded / data.total * 100, 10)
      percentage = progress.toString() + '%'
      data.progressBar.find(".progress-bar").css("width", percentage).html(percentage)
    done: (e, data) =>
      data.progressBar.remove()
      image = {
        id: data.formData.key.match(/cache\/(.+)/)[1]
        storage: 'cache',
        metadata: {
          size:      data.files[0].size,
          filename:  data.files[0].name.match(/[^\/\\]+$/)[0],
          mime_type: data.files[0].type
        }
      }
      $('#photo_hidden').val(JSON.stringify(image))
      $( "<p>Upload done</p>" ).insertAfter('#product_photo')
