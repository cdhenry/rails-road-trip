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
});
