function addMagnific(selector) {
  $(selector).magnificPopup({
    type: 'image',
    delegate: 'a',
    gallery: {
      enabled: true,
    },
    callbacks: {
      beforeOpen: function () {
        var magnificPopup = $.magnificPopup.instance,
          cur = magnificPopup.st.el.focus();
      },
      open: function () {
        $('.container').addClass('blur');
      },
      close: function () {
        $('.container').removeClass('blur');
      }
    }
  });
}

function addMagnificVideo(selector) {
  $(selector).magnificPopup({
    type: 'iframe',
    mainClass: 'mfp-fade',
    preloader: true,
    callbacks: {
      beforeOpen: function () {
        var magnificPopup = $.magnificPopup.instance,
          cur = magnificPopup.st.el.focus();
      },
      open: function () {
        $('.container').addClass('blur');
      },
      close: function () {
        $('.container').removeClass('blur');
      }
    }
  });
}

function addDrag(selector) {
  const sliders = document.getElementsByClassName(selector);

  for (i = 0; i < sliders.length; i++) {
    const slider = sliders[i];
    let isDown = false;
    let startX;
    let scrollLeft;

    slider.addEventListener('mousedown', (e) => {
      isDown = true;
      
      startX = e.pageX - slider.offsetLeft;
      scrollLeft = slider.scrollLeft;
    });
    slider.addEventListener('mouseleave', () => {
      isDown = false;
      slider.classList.remove('active');
    });
    slider.addEventListener('mouseup', () => {
      isDown = false;
      slider.classList.remove('active');
    });
    slider.addEventListener('mousemove', (e) => {
      if (!isDown) return;
      slider.classList.add('active');
      e.preventDefault();
      const x = e.pageX - slider.offsetLeft;
      const walk = (x - startX) * 3; //scroll-fast
      slider.scrollLeft = scrollLeft - walk;
    });
  }
}

function youtube_parser(url) {
  var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
  var match = url.match(regExp);
  return (match && match[7].length == 11) ? match[7] : false;
}

function removeVideo(video_id){
  video_links[video_id] = null;
  $('#video-' + video_id).remove();
}

function alertRemove(){
  $('.ex-alert').remove();
}