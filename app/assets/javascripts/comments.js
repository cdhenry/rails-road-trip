$(function(){
  $("#load_comments").on("click", function(e){
    $.get(this.href).success(function(json){
      let $ul = $("div.comments ul");
      $ul.html(" ")
      json.forEach(function(comment){
        $ul.append("<li>" + comment.author.name + " : " + comment.body + "</li>")
      });
    });
    e.preventDefault();
  });
});
