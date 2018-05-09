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
  $tbody.html(" ");
  tag.showDestinations($tbody);
}

const getTag = function(){
  var nextId = parseInt($(".js-next-tag").attr("data-id")) + 1;
  $.get("/tags/" + nextId + ".json").done(Tag.done);
}

const setAttributes = function (){

}

const nextTag = function(){
  $(".js-next-tag").on("click", function(e) {
    getTag();
    e.preventDefault();
  })
}

const previousTag = function(){
  $(".js-previous-tag").on("click", function(e) {
    e.preventDefault();
    
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

// $(function(){
//   const getNextItemForShow = function(){
//     $(".js-next-tag").on("click", function(e) {
//       var nextId = parseInt($(".js-next-tag").attr("data-id")) + 1;
//       $.get("/tags/" + nextId + ".json", function(data) {
//         $(".tagName").text(data["name"]);
//         var $tbody = $("tbody.tags_destinations")
//         $tbody.html(" ");
//         data.destinations.forEach(function(destination){
//           $tbody.append(
//             `<tr class="table-active">
//               <td>${destination.name}</td>
//               <td>${destination.city}, ${destination.state}</td>
//               <td>${destination.street_address}</td>
//             </tr>`
//           )
//         })
//         // re-set the id to current on the link
//         $(".js-next-tag").attr("data-id", data["id"]);
//         $(".js-previous-tag").attr("data-id", data["id"]);
//         e.preventDefault();
//       });
//     });
//
//   $(".js-previous-tag").on("click", function(e) {
//     var previousId = parseInt($(".js-next-tag").attr("data-id")) - 1;
//     $.get("/tags/" + previousId + ".json", function(data) {
//       $(".tagName").text(data["name"]);
//       var $tbody = $("tbody.tags_destinations");
//       $tbody.html(" ");
//       data.destinations.forEach(function(destination){
//         $tbody.append(
//           `<tr class="table-active">
//             <td>${destination.name}</td>
//             <td>${destination.city}, ${destination.state}</td>
//             <td>${destination.street_address}</td>
//           </tr>`
//         )
//       });
//       // re-set the id to current on the link
//       $(".js-previous-tag").attr("data-id", data["id"]);
//       $(".js-next-tag").attr("data-id", data["id"]);
//       e.preventDefault();
//     });
//   });

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
// });
