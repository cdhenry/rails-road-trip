$(function(){
  $("a.load_comments").on("click", function(e){
    $.get(this.href).success(function(json){
      let $ol = $("div.comments ol");
      $ol.html("")
      json.forEach(function(comment){
        $ol.append("<li>" + comment.author_id + " : " + comment.body + "</li>")
      });
    });
    e.preventDefault();
  });
});
