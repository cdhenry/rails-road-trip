$(function(){
  $("#load_comments").on("click", function(e){
    $.get(this.href).success(function(json){
      let $ul = $("div.comments ul");
      $ul.html(" ");
      json.forEach(function(comment){
        $ul.append("<li>" + comment.author.name + " : " + comment.body + "</li>")
      });
    });
    e.preventDefault();
  });

  $("#hide_comments").on("click", function(e){
    let $ul = $("div.comments ul");
    $ul.html(" ")
    e.preventDefault();
  });

  $("#new_comment").on("submit", function(e){
    $.ajax({
      type: ($("input[name='_method']").val() || this.method),
      url: this.action,
      data: $(this).serialize()
    }).success(function(response){
        $("#comment_body").val("");
        let $ul = $("div.comments ul");
        $ul.append(response);
      });
    e.preventDefault();
  });

  $("#comments_made").on("click", function(e){
    $.get(this.href).success(function(json){
      let $ul = $("div.comments ul");
      $ul.html(" ");
      json.forEach(function(comment){
        $ul.append("<li>" + comment.type_object.title + " (" + comment.commentable_type.split(/(?=[A-Z])/).join(" ") + ") : " + comment.body + "</li>")
      });
    });
    e.preventDefault();
  });

  $("#comments_received").on("click", function(e){
    $.get(this.href).success(function(json){
      let $ul = $("div.comments ul");
      $ul.html(" ");
      json.forEach(function(comment){
        $ul.append("<li>" + comment.author.name + " : " + comment.body + "</li>")
      });
    });
    e.preventDefault();
  });

  $(".js-next-tag").on("click", function() {
    let nextId = parseInt($(".js-next-tag").attr("data-id")) + 1;
    $.get("/tags/" + nextId + ".json", function(data) {
      debugger;
      let $tbody = $("tbody.tags_destinations")
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
    });
  });
});
