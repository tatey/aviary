(function($) {
  $.fn.blockquote = function() {
    this
      .hide()
      .after($('<span>', {
        className: 'status', 
        click: function() {
          $(this).fadeOut(0.5, function() {
            $(this)
              .prev()
              .fadeIn();
          });
        }
      }).html('&#9660;'));
  }

  $(document).ready(function() {
    $('blockquote').blockquote();
  });
})(jQuery);
