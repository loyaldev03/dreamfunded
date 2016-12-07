  $("document").ready(function(){

      var activeWindow;
          var id = '#invite-dialog'
          console.log(id);
          activeWindow = $('.window' + id)


      $('a.close-button').click(function(e){
              e.preventDefault();
              closeModal();
      });
      $('a.close').click(function(e){
              e.preventDefault();
              closeModal();
      });
      $('.invt-fr-btn').click(function(e){
            e.preventDefault();
            activeWindow = $('.window' + id)
                .css('opacity', '0') // set to an initial 0 opacity
                .css('top', '35%') // position vertically at 50%
                .css('left', '35%') // position horizontally at 50%
                .fadeTo(500, 1); // fade to an opacity of 1 (100%) over 500 milliseconds

            $('#modal')
                .append('<div id="blind" />') // create a <div> with an id of 'blind'
                .find('#blind') // select the div we've just created
                .css('opacity', '0') // set the initial opacity to 0
                .fadeTo(500, 0.5) // fade in to an opacity of 0.8 (80%) over 500 milliseconds
                .click(function(e){
                    closeModal(); // close modal if someone clicks anywhere on the blind (outside of the window)
                });

      });
      function closeModal() {
          activeWindow.fadeOut(250, function(){ $(this).css('top', '-1000px').css('left', '-1000px'); });
          $('#blind').fadeOut(250,    function(){ $(this).remove(); });
      }

  });
