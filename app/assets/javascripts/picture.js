$(function(){
  $(".js-next-pic").on("click", function(e) {
    $.get(this.href).success(function(data) {
      var counter = parseInt($(".js-next-pic").attr("data-id")) + 1;
      if (counter < data.length){
        $(".image_url")[0].src = data[counter]["url"] + new Date().getTime();
        // re-set the id to current on the link
        $(".js-next-pic").attr("data-id", counter);
        $(".js-previous-pic").attr("data-id", counter);
      }else {
        counter = parseInt($(".js-next-pic").attr("data-id")) - 1;
      }
    });
    e.preventDefault();
  });

  $(".js-previous-pic").on("click", function(e) {
    $.get(this.href).success(function(data) {
      var counter = parseInt($(".js-previous-pic").attr("data-id")) - 1;
      if (counter > -1){
        $(".image_url")[0].src = data[counter]["url"] + new Date().getTime();
        // re-set the id to current on the link
        $(".js-next-pic").attr("data-id", counter);
        $(".js-previous-pic").attr("data-id", counter);
      }else {
        counter = parseInt($(".js-previous-pic").attr("data-id")) + 1;
      }
    });
    e.preventDefault();
  });
});
