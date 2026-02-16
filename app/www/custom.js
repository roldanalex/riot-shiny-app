// Copy to clipboard handler
Shiny.addCustomMessageHandler('copyToClipboard', function(text) {
  navigator.clipboard.writeText(text).then(function() {
    var btn = document.getElementById('copy_btn');
    if (btn) {
      var originalHTML = btn.innerHTML;
      btn.innerHTML = '<i class="fa fa-check"></i> Copied!';
      btn.classList.remove('btn-outline-secondary');
      btn.classList.add('btn-success');
      setTimeout(function() {
        btn.innerHTML = originalHTML;
        btn.classList.remove('btn-success');
        btn.classList.add('btn-outline-secondary');
      }, 2000);
    }
  }).catch(function(err) {
    // Fallback for older browsers
    var textarea = document.createElement('textarea');
    textarea.value = text;
    textarea.style.position = 'fixed';
    textarea.style.opacity = '0';
    document.body.appendChild(textarea);
    textarea.select();
    document.execCommand('copy');
    document.body.removeChild(textarea);

    var btn = document.getElementById('copy_btn');
    if (btn) {
      var originalHTML = btn.innerHTML;
      btn.innerHTML = '<i class="fa fa-check"></i> Copied!';
      btn.classList.remove('btn-outline-secondary');
      btn.classList.add('btn-success');
      setTimeout(function() {
        btn.innerHTML = originalHTML;
        btn.classList.remove('btn-success');
        btn.classList.add('btn-outline-secondary');
      }, 2000);
    }
  });
});

// Camera capture bridge for mobile
$(document).on('change', '#camera_input', function(e) {
  var files = e.target.files;
  if (files.length > 0) {
    var file = files[0];
    var reader = new FileReader();
    reader.onload = function(event) {
      Shiny.setInputValue('camera_capture', {
        name: file.name,
        size: file.size,
        type: file.type,
        datapath: event.target.result
      });
    };
    reader.readAsDataURL(file);
  }
});
