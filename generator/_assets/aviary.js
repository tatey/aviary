(function($) {
  $(document).ready(function() {
    // Remove photos that failed to load after 20 seconds.
    window.setTimeout(function() {
      $('img.photo:hidden')
        .closest('li')
        .fadeOut(function() {
          $(this)
            .remove();
        });
    }, 20000);
        
    $('li').each(function(i, el) {
      var $el = $(el);
      // Hide contents of each list element.
      $el
        .children()
        .hide();
      // Prepend the loader.
      $el
        .prepend($('<img>', {src: '/loader.gif', className: 'loader'}));
      // When the photo loads, remove the loader and show the photo.
      $el
        .find('img.photo')
        .load(function() {
          $el
            .children('img.loader')
            .fadeOut(function() {
              $(this)
                .remove();
              $el
                .children()
                .fadeIn();
            });
        });
    });
  });
})(jQuery);
