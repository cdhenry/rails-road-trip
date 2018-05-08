function Tag(tag) {
    this.id = tag.id;
    this.name = tag.name;
    this.destinations = tag.destinations;
}

const getNextItemForShow = function(){
  $(".js-next-tag").on("click", function(e) {
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
      e.preventDefault();
    });
  });
}

$(function(){
  const getNextItemForShow = function(){
    $(".js-next-tag").on("click", function(e) {
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
        e.preventDefault();
      });
    });

  $(".js-previous-tag").on("click", function(e) {
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
      $(".js-next-tag").attr("data-id", data["id"]);
      e.preventDefault();
    });
  });

  // $("#new_tag").on("submit", function(e){
  //   $.ajax({
  //     type: ($("input[name='_method']").val() || this.method),
  //     url: this.action,
  //     data: $(this).serialize()
  //   }).success(function(response){
  //       $("#tag_name").val("");
  //       let $ul = $("ul.tags-list");
  //       $ul.append(
  //         `<li class='list-group-item'>${response.name}</li>`
  //       );
  //     });
  //   e.preventDefault();
  // });
});
