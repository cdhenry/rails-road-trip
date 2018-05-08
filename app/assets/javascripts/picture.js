$(function(){
  $(".js-next-pic").on("click", function() {
    debugger;
    var nextId = parseInt($(".js-next-pic").attr("data-id")) + 1;
    $.get("/users/pictures/" + nextId + ".json", function(data) {
      $(".image_url").src(data["url"]);

      // re-set the id to current on the link
      $(".js-next-pic").attr("data-id", data["id"]);
      $(".js-previous-pic").attr("data-id", data["id"]);
    });
  });
  
  $(".js-previous-pic").on("click", function() {
    var previousId = parseInt($(".js-next-pic").attr("data-id")) - 1;
    $.get("/pictures/" + previousId + ".json", function(data) {
      $(".image_url").src(data["url"]);

      // re-set the id to current on the link
      $(".js-previous-pic").attr("data-id", data["id"]);
      $(".js-next-pic").attr("data-id", data["id"])
    });
  });
});