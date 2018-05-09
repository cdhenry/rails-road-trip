function Tag(tag) {
    this.id = tag.id;
    this.name = tag.name;
    this.destinations = tag.destinations;
}

Tag.prototype.showDestinations = function (wrapper) {
  this.destinations.forEach(function(destination){
    wrapper.append(
      `<tr class="table-active">
        <td>${destination.name}</td>
        <td>${destination.city}, ${destination.state}</td>
        <td>${destination.street_address}</td>
      </tr>`)
  })
}

Tag.done = function(response) {
  let $tbody = $("tbody.tags_destinations")
  let tag = new Tag(response);
  $(".tagName").text(tag.name);
  $tbody.html(" ");
  tag.showDestinations($tbody);
}

const getTag = function(id){
  $.get("/tags/" + id + ".json").done(Tag.done);
  setAttributes(id);
}

const setAttributes = function (id){
  $(".js-next-tag").attr("data-id", id);
  $(".js-previous-tag").attr("data-id", id);
}

const nextTag = function(){
  $(".js-next-tag").on("click", function(e) {
    let total = parseInt($(".js-next-tag").attr("data-total"))
    let id = parseInt($(".js-next-tag").attr("data-id"))
    if (total > id){
      var nextId = id + 1;
      getTag(nextId);
    }
    e.preventDefault();
  });
}

const previousTag = function(){
  $(".js-previous-tag").on("click", function(e) {
    if (-1 < parseInt($(".js-previous-tag").attr("data-id"))){
      var previousId = parseInt($(".js-previous-tag").attr("data-id")) - 1;
      getTag(previousId);
    }
    e.preventDefault();
  });
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

$(function() {
  nextTag();
  previousTag();
})

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
