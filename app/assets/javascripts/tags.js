$(function(){
  $(".js-next-tag").on("click", function() {
    var nextId = parseInt($(".js-next-tag").attr("data-id")) + 1;
    $.get("/tags/" + nextId + ".json", function(data) {
      $(".tagName").text(data["name"]);
      var $tbody = $("tbody.tags_destinations")
      $tbody.html(" ");
      data.destinations.forEach(function(destination){
        $tbody.append(
          `<tr class="table-active">
            <td>${destination.name}</td>
            <td>${destination.city}, ${destination.state}</td>
            <td>${destination.street_address}</td>
          </tr>`
        )
      })
      // re-set the id to current on the link
      $(".js-next-tag").attr("data-id", data["id"]);
      $(".js-previous-tag").attr("data-id", data["id"]);
    });
  });
  
  $(".js-previous-tag").on("click", function() {
    var previousId = parseInt($(".js-next-tag").attr("data-id")) - 1;
    $.get("/tags/" + previousId + ".json", function(data) {
      $(".tagName").text(data["name"]);
      var $tbody = $("tbody.tags_destinations")
      $tbody.html(" ");
      data.destinations.forEach(function(destination){
        $tbody.append(
          `<tr class="table-active">
            <td>${destination.name}</td>
            <td>${destination.city}, ${destination.state}</td>
            <td>${destination.street_address}</td>
          </tr>`
        )
      })
      // re-set the id to current on the link
      $(".js-previous-tag").attr("data-id", data["id"]);
      $(".js-next-tag").attr("data-id", data["id"])
    });
  });
});