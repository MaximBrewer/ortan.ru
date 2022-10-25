function getURLVar(key) {
  var value = [];

  var query = document.location.search.split("?");

  if (query[1]) {
    var part = query[1].split("&");

    for (i = 0; i < part.length; i++) {
      var data = part[i].split("=");

      if (data[0] && data[1]) {
        value[data[0]] = data[1];
      }
    }

    if (value[key]) {
      return value[key];
    } else {
      return "";
    }
  }
}

$(document).ready(function () {
  $(document).on("click", ".product__openFancy", function (e) {
    fastView(e);
  });
  // Highlight any found errors
  $(".text-danger").each(function () {
    var element = $(this).parent().parent();

    if (element.hasClass("form-group")) {
      element.addClass("has-error");
    }
  });

  // Currency
  $("#form-currency .currency-select").on("click", function (e) {
    e.preventDefault();

    $("#form-currency input[name='code']").val($(this).attr("name"));

    $("#form-currency").submit();
  });

  // Language
  $("#form-language .language-select").on("click", function (e) {
    e.preventDefault();

    $("#form-language input[name='code']").val($(this).attr("name"));

    $("#form-language").submit();
  });

  /* Search */
  $("#search input[name='search']")
    .parent()
    .find("button")
    .on("click", function () {
      var url = "index.php?route=product/search";

      var value = $("header #search input[name='search']").val();

      if (value) {
        url += "&search=" + encodeURIComponent(value);
      }

      location = url;
    });

  $("#search input[name='search']").on("keydown", function (e) {
    if (e.keyCode == 13) {
      $("header #search input[name='search']")
        .parent()
        .find("button")
        .trigger("click");
    }
  });

  // Menu
  $("#menu .dropdown-menu").each(function () {
    var menu = $("#menu").offset();
    var dropdown = $(this).parent().offset();

    var i =
      dropdown.left +
      $(this).outerWidth() -
      (menu.left + $("#menu").outerWidth());

    if (i > 0) {
      $(this).css("margin-left", "-" + (i + 10) + "px");
    }
  });

  // Product List
  $("#list-view").click(function () {
    $("#content .product-grid > .clearfix").remove();

    $("#content .row > .product-grid").attr(
      "class",
      "product-layout product-list col-xs-12"
    );
    $("#grid-view").removeClass("active");
    $("#list-view").addClass("active");

    localStorage.setItem("display", "list");
  });

  // Product Grid
  $("#grid-view").click(function () {
    // What a shame bootstrap does not take into account dynamically loaded columns
    var cols = $("#column-right, #column-left").length;

    if (cols == 2) {
      $("#content .product-list").attr(
        "class",
        "product-layout product-grid col-lg-6 col-md-6 col-sm-12 col-xs-12"
      );
    } else if (cols == 1) {
      $("#content .product-list").attr(
        "class",
        "product-layout product-grid col-lg-4 col-md-4 col-sm-6 col-xs-12"
      );
    } else {
      $("#content .product-list").attr(
        "class",
        "product-layout product-grid col-lg-3 col-md-3 col-sm-6 col-xs-12"
      );
    }

    $("#list-view").removeClass("active");
    $("#grid-view").addClass("active");

    localStorage.setItem("display", "grid");
  });

  if (localStorage.getItem("display") == "list") {
    $("#list-view").trigger("click");
    $("#list-view").addClass("active");
  } else {
    $("#grid-view").trigger("click");
    $("#grid-view").addClass("active");
  }

  // Checkout
  $(document).on(
    "keydown",
    "#collapse-checkout-option input[name='email'], #collapse-checkout-option input[name='password']",
    function (e) {
      if (e.keyCode == 13) {
        $("#collapse-checkout-option #button-login").trigger("click");
      }
    }
  );

  // // tooltips on hover
  // $('[data-toggle=\'tooltip\']').tooltip({container: 'body',trigger: 'hover'});

  // // Makes tooltips work on ajax generated content
  // $(document).ajaxStop(function() {
  // 	$('[data-toggle=\'tooltip\']').tooltip({container: 'body'});
  // });
});

// Cart add remove functions
var cart = {
  add: function (product_id, quantity, silent) {
    $.ajax({
      url: "index.php?route=checkout/cart/add",
      type: "post",
      data:
        "product_id=" +
        product_id +
        "&quantity=" +
        (typeof quantity != "undefined" ? quantity : 1),
      dataType: "json",
      beforeSend: function () {
        // $('#cart > button').button('loading');
      },
      complete: function () {
        // $('#cart > button').button('reset');
      },
      success: function (json) {
        $(".alert, .text-danger, .productm__addToCart").remove();

        if (json["redirect"]) {
          location = json["redirect"];
        }

        if (json["success"]) {
          if (!silent) {
            $("body").prepend(
              '<div class="productm__addToCart productm__addToCart_red" style="display: flex;"><svg class="productm__addOk" width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M19.9184 2.8527L7.51783 15.2533C7.40861 15.3625 7.23175 15.3625 7.12278 15.2533L0.0817287 8.21196C-0.0272429 8.10325 -0.0272429 7.92639 0.0817287 7.81716L1.79261 6.10628C1.90184 5.99731 2.07869 5.99731 2.18766 6.10628L7.32056 11.2389L17.8127 0.746768C17.9222 0.637796 18.0985 0.637796 18.2078 0.746768L19.9184 2.45765C20.0276 2.56662 20.0276 2.74322 19.9184 2.8527Z" fill="white"></path></svg><p class="productm__addInfo">' +
              json["success"] +
              '</p><svg class="productm__addClose" width="15" height="15" viewBox="0 0 15 15" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M15 1.76757L13.2324 0L7.49998 5.73241L1.76757 0L0 1.76757L5.73241 7.49998L0 13.2324L1.76757 15L7.49998 9.26759L13.2324 15L15 13.2324L9.26759 7.49998L15 1.76757Z" fill="white"></path></svg></div>'
            );
            // Need to set timeout otherwise it wont update the total
            // setTimeout(function () {
            // 	$('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
            // }, 100);

            // $("html, body").animate({ scrollTop: 0 }, "slow");
          }
          $("#cart").load("index.php?route=common/cart/info", function () {
            $(".cartPopup__list").mCustomScrollbar();
          });
        }
      },
      error: function (xhr, ajaxOptions, thrownError) {
        alert(
          thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText
        );
      },
    });
    ym('53398495','reachGoal','korzinaKatalog');
  },
  updateAjax: function (id, quantity) {
    $.ajax({
      url: "index.php?route=checkout/checkout/editAjax",
      type: "post",
      data:
        "key=" +
        id +
        "&quantity=" +
        (typeof quantity != "undefined" ? quantity : 1),
      dataType: "json",
      beforeSend: function () {
        // $('#cart > button').button('loading');
      },
      complete: function () {
        // $('#cart > button').button('reset');
      },
      success: function (json) {
        $("#ordering").load(
          "index.php?route=checkout/checkout/info",
          function () {
            $(".cartPopup__list").mCustomScrollbar();
          }
        );
        if ($("#cart ul").length) {
          $("#cart ul").load(
            "index.php?route=common/cart/info ul li",
            function (data) {
              $("#cart .cartPopup__all > div > div span").text(
                $(" .cartPopup__all > div > div span", data).text()
              );
              $(".cartPopup__list").mCustomScrollbar();
            }
          );
        } else {
          $("#cart").load("index.php?route=common/cart/info", function () {
            $(".cartPopup__list").mCustomScrollbar();
          });
        }
      },
      error: function (xhr, ajaxOptions, thrownError) {
        alert(
          thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText
        );
      },
    });
  },
  update: function (key, quantity) {
    $.ajax({
      url: "index.php?route=checkout/cart/edit",
      type: "post",
      data:
        "key=" +
        key +
        "&quantity=" +
        (typeof quantity != "undefined" ? quantity : 1),
      dataType: "json",
      beforeSend: function () {
        // $('#cart > button').button('loading');
      },
      complete: function () {
        // $('#cart > button').button('reset');
      },
      success: function (json) {
        // Need to set timeout otherwise it wont update the total
        setTimeout(function () {
          $("#cart > button").html(
            '<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' +
            json["total"] +
            "</span>"
          );
        }, 100);

        if (
          getURLVar("route") == "checkout/cart" ||
          getURLVar("route") == "checkout/checkout"
        ) {
          location = "index.php?route=checkout/cart";
        } else {
          $("#cart").load("index.php?route=common/cart/info", function () {
            $(".cartPopup__list").mCustomScrollbar();
          });
        }
      },
      error: function (xhr, ajaxOptions, thrownError) {
        alert(
          thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText
        );
      },
    });
  },
  remove: function (key) {
    $.ajax({
      url: "index.php?route=checkout/cart/remove",
      type: "post",
      data: "key=" + key,
      dataType: "json",
      beforeSend: function () {
        // $('#cart > button').button('loading');
      },
      complete: function () {
        // $('#cart > button').button('reset');
      },
      success: function (json) {
        // Need to set timeout otherwise it wont update the total
        setTimeout(function () {
          $("#cart > button").html(
            '<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' +
            json["total"] +
            "</span>"
          );
        }, 100);

        var now_location = String(document.location.pathname);

        if (
          now_location == "/cart/" ||
          now_location == "/checkout/" ||
          getURLVar("route") == "checkout/cart" ||
          getURLVar("route") == "checkout/checkout"
        ) {
          location = "index.php?route=checkout/cart";
        } else {
          $("#cart").load("index.php?route=common/cart/info", function () {
            $(".cartPopup__list").mCustomScrollbar();
          });
        }
      },
      error: function (xhr, ajaxOptions, thrownError) {
        alert(
          thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText
        );
      },
    });
  },
  removeAjax: function (key) {
    $.ajax({
      url: "index.php?route=checkout/cart/remove",
      type: "post",
      data: "key=" + key,
      dataType: "json",
      beforeSend: function () {
        // $('#cart > button').button('loading');
      },
      complete: function () {
        // $('#cart > button').button('reset');
      },
      success: function (json) {
        $("#ordering").load(
          "index.php?route=checkout/checkout/info",
          function () {
            $(".cartPopup__list").mCustomScrollbar();
          }
        );
        if ($("#cart ul").length) {
          $("#cart ul").load(
            "index.php?route=common/cart/info ul li",
            function () {
              $(".cartPopup__list").mCustomScrollbar();
            }
          );
        } else {
          $("#cart").load("index.php?route=common/cart/info", function () {
            $(".cartPopup__list").mCustomScrollbar();
          });
        }
      },
      error: function (xhr, ajaxOptions, thrownError) {
        alert(
          thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText
        );
      },
    });
  },
};

var voucher = {
  add: function () { },
  remove: function (key) {
    $.ajax({
      url: "index.php?route=checkout/cart/remove",
      type: "post",
      data: "key=" + key,
      dataType: "json",
      beforeSend: function () {
        // $('#cart > button').button('loading');
      },
      complete: function () {
        // $('#cart > button').button('reset');
      },
      success: function (json) {
        // Need to set timeout otherwise it wont update the total
        setTimeout(function () {
          $("#cart > button").html(
            '<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' +
            json["total"] +
            "</span>"
          );
        }, 100);

        if (
          getURLVar("route") == "checkout/cart" ||
          getURLVar("route") == "checkout/checkout"
        ) {
          location = "index.php?route=checkout/cart";
        } else {
          $("#cart").load("index.php?route=common/cart/info", function () {
            $(".cartPopup__list").mCustomScrollbar();
          });
        }
      },
      error: function (xhr, ajaxOptions, thrownError) {
        alert(
          thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText
        );
      },
    });
  },
};

var wishlist = {
  add: function (product_id) {
    $.ajax({
      url: "index.php?route=account/wishlist/add",
      type: "post",
      data: "product_id=" + product_id,
      dataType: "json",
      success: function (json) {
        $(".alert, .text-danger, .productm__addToCart").remove();

        if (json["redirect"]) {
          location = json["redirect"];
        }

        if (json["success"]) {
          $("body").prepend(
            '<div class="productm__addToCart productm__addToCart_white" style="display: flex;"><svg class="productm__addOk" width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M19.9184 2.8527L7.51783 15.2533C7.40861 15.3625 7.23175 15.3625 7.12278 15.2533L0.0817287 8.21196C-0.0272429 8.10325 -0.0272429 7.92639 0.0817287 7.81716L1.79261 6.10628C1.90184 5.99731 2.07869 5.99731 2.18766 6.10628L7.32056 11.2389L17.8127 0.746768C17.9222 0.637796 18.0985 0.637796 18.2078 0.746768L19.9184 2.45765C20.0276 2.56662 20.0276 2.74322 19.9184 2.8527Z" fill="white"></path></svg><p class="productm__addInfo">' +
            json["success"] +
            '</p><svg class="productm__addClose" width="15" height="15" viewBox="0 0 15 15" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M15 1.76757L13.2324 0L7.49998 5.73241L1.76757 0L0 1.76757L5.73241 7.49998L0 13.2324L1.76757 15L7.49998 9.26759L13.2324 15L15 13.2324L9.26759 7.49998L15 1.76757Z" fill="white"></path></svg></div>'
          );
          typeof refreshWishlist !== "undefined" &&
            refreshWishlist(json["wishlist"]);
        }

        $("#wishlist-total span").html(json["total"]);
        $("#wishlist-total").attr("title", json["total"]);

        // $("html, body").animate({ scrollTop: 0 }, "slow");
      },
      error: function (xhr, ajaxOptions, thrownError) {
        alert(
          thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText
        );
      },
    });
    ym(53398495,'reachGoal','addToFavorites');
  },
  remove: function () { },
};

var fastView = function (e) {
  e.stopPropagation();
  e.preventDefault();
  $("#fastViewModal").remove();
  $("body").append(
    '<div class="modal fade" tabindex="-1" role="dialog" id="fastViewModal"><div class="modal-dialog modal-lg" role="document"><div class="modal-content"></div></div></div>'
  );
  $("#fastViewModal .modal-content").load(
    "index.php?route=product/product&product_id=" +
    $(e.target).data("product_id") +
    "&ajax=1",
    function () {
      $("#fastViewModal").modal("show");
    }
  );
  return false;
};

var compare = {
  add: function (product_id) {
    $.ajax({
      url: "index.php?route=product/compare/add",
      type: "post",
      data: "product_id=" + product_id,
      dataType: "json",
      success: function (json) {
        $(".alert, .text-danger, .productm__addToCart").remove();

        if (json["success"]) {
          $("#compare-total").html(json["total"]);

          $("body").prepend(
            '<div class="productm__addToCart productm__addToCart_comparison" style="display: flex;"><svg class="productm__addOk" width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M19.9184 2.8527L7.51783 15.2533C7.40861 15.3625 7.23175 15.3625 7.12278 15.2533L0.0817287 8.21196C-0.0272429 8.10325 -0.0272429 7.92639 0.0817287 7.81716L1.79261 6.10628C1.90184 5.99731 2.07869 5.99731 2.18766 6.10628L7.32056 11.2389L17.8127 0.746768C17.9222 0.637796 18.0985 0.637796 18.2078 0.746768L19.9184 2.45765C20.0276 2.56662 20.0276 2.74322 19.9184 2.8527Z" fill="white"></path></svg><p class="productm__addInfo">' +
            json["success"] +
            '</p><svg class="productm__addClose" width="15" height="15" viewBox="0 0 15 15" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M15 1.76757L13.2324 0L7.49998 5.73241L1.76757 0L0 1.76757L5.73241 7.49998L0 13.2324L1.76757 15L7.49998 9.26759L13.2324 15L15 13.2324L9.26759 7.49998L15 1.76757Z" fill="white"></path></svg></div>'
          );
          typeof refreshCompare !== "undefined" &&
            refreshCompare(json["compare"]);

          // $("html, body").animate({ scrollTop: 0 }, "slow");
        }
      },
      error: function (xhr, ajaxOptions, thrownError) {
        alert(
          thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText
        );
      },
    });
  },
  remove: function () { },
};

/* Agree to Terms */
$(document).delegate(".agree", "click", function (e) {
  e.preventDefault();

  $("#modal-agree").remove();

  var element = this;

  $.ajax({
    url: $(element).attr("href"),
    type: "get",
    dataType: "html",
    success: function (data) {
      html = '<div id="modal-agree" class="modal">';
      html += '  <div class="modal-dialog">';
      html += '    <div class="modal-content">';
      html += '      <div class="modal-header">';
      html +=
        '        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
      html += '        <h4 class="modal-title">' + $(element).text() + "</h4>";
      html += "      </div>";
      html += '      <div class="modal-body">' + data + "</div>";
      html += "    </div";
      html += "  </div>";
      html += "</div>";

      $("body").append(html);

      $("#modal-agree").modal("show");
    },
  });
});

// Autocomplete */
(function ($) {
  $.fn.autocomplete = function (option) {
    return this.each(function () {
      this.timer = null;
      this.items = new Array();

      $.extend(this, option);

      $(this).attr("autocomplete", "off");

      // Focus
      $(this).on("focus", function () {
        this.request();
      });

      // Blur
      $(this).on("blur", function () {
        setTimeout(
          function (object) {
            object.hide();
          },
          200,
          this
        );
      });

      // Keydown
      $(this).on("keydown", function (event) {
        switch (event.keyCode) {
          case 27: // escape
            this.hide();
            break;
          default:
            this.request();
            break;
        }
      });

      // Click
      this.click = function (event) {
        event.preventDefault();

        value = $(event.target).parent().attr("data-value");

        if (value && this.items[value]) {
          this.select(this.items[value]);
        }
      };

      // Show
      this.show = function () {
        var pos = $(this).position();

        $(this)
          .siblings("ul.dropdown-menu")
          .css({
            top: pos.top + $(this).outerHeight(),
            left: pos.left,
          });

        $(this).siblings("ul.dropdown-menu").show();
      };

      // Hide
      this.hide = function () {
        $(this).siblings("ul.dropdown-menu").hide();
      };

      // Request
      this.request = function () {
        clearTimeout(this.timer);

        this.timer = setTimeout(
          function (object) {
            object.source($(object).val(), $.proxy(object.response, object));
          },
          200,
          this
        );
      };

      // Response
      this.response = function (json) {
        html = "";

        if (json.length) {
          for (i = 0; i < json.length; i++) {
            this.items[json[i]["value"]] = json[i];
          }

          for (i = 0; i < json.length; i++) {
            if (!json[i]["category"]) {
              html +=
                '<li data-value="' +
                json[i]["value"] +
                '"><a href="#">' +
                json[i]["label"] +
                "</a></li>";
            }
          }

          // Get all the ones with a categories
          var category = new Array();

          for (i = 0; i < json.length; i++) {
            if (json[i]["category"]) {
              if (!category[json[i]["category"]]) {
                category[json[i]["category"]] = new Array();
                category[json[i]["category"]]["name"] = json[i]["category"];
                category[json[i]["category"]]["item"] = new Array();
              }

              category[json[i]["category"]]["item"].push(json[i]);
            }
          }

          for (i in category) {
            html +=
              '<li class="dropdown-header">' + category[i]["name"] + "</li>";

            for (j = 0; j < category[i]["item"].length; j++) {
              html +=
                '<li data-value="' +
                category[i]["item"][j]["value"] +
                '"><a href="#">&nbsp;&nbsp;&nbsp;' +
                category[i]["item"][j]["label"] +
                "</a></li>";
            }
          }
        }

        if (html) {
          this.show();
        } else {
          this.hide();
        }

        $(this).siblings("ul.dropdown-menu").html(html);
      };

      $(this).after('<ul class="dropdown-menu"></ul>');
      $(this)
        .siblings("ul.dropdown-menu")
        .delegate("a", "click", $.proxy(this.click, this));
    });
  };
})(window.jQuery);

$(function () {
  $(document).on("click", ".productm .cartPopup__more", function () {
    var input = $(this).parent().find("[name=quantity]");
    var q = $(input).val();
    q = $(input).val() * 1 + $(input).data("minimum") * 1;
    $(input).val(q);
    $(this).parent().find(".cartPopup__number").text(q);
  });
  $(document).on("click", ".productm .cartPopup__less", function () {
    var input = $(this).parent().find("[name=quantity]");
    var q = $(input).val();
    q = $(input).val() * 1 - $(input).data("minimum") * 1;
    if (q) {
      $(input).val(q);
      $(this).parent().find(".cartPopup__number").text(q);
    }
  });
  typeof wishlistIds !== "undefined" && refreshWishlist(wishlistIds);
  typeof compareIds !== "undefined" && refreshCompare(compareIds);
});


function refreshWishlist(wishlistIds) {
  wishlistIds =
    typeof wishlistIds == "object" ? Object.values(wishlistIds) : wishlistIds;
  for (id of wishlistIds) {
    $("[data-wishlist=" + id + "]").addClass("wishlist");
  }
}

function refreshCompare(compareIds) {
  compareIds =
    typeof compareIds == "object" ? Object.values(compareIds) : compareIds;
  for (id of compareIds) {
    $("[data-compare=" + id + "]").addClass("compare");
  }
}



$(function () {
  $(document).on("click", "[data-compare]", function (e) {
    if (!$(this).hasClass("compare")) {
      e.preventDefault();
      compare.add($(this).data("compare"));
    }
  });
  $(document).on("click", "[data-wishlist]", function (e) {
    if (!$(this).hasClass("wishlist")) {
      e.preventDefault();
      wishlist.add($(this).data("wishlist"));
    }
  });
  $('a[href^="#"').on('click', function() {
  
      let href = $(this).attr('href');
  
      $('html, body').animate({
          scrollTop: $(href).offset().top - 100
      });
      return false;
  });
});
