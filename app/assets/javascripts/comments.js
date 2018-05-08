function Comment(comment) {
    this.id = comment.id;
    this.body = comment.body;
    this.author = comment.author;
    this.commentable_type = comment.commentable_type;
    this.type_object = comment.type_object;
}

Comment.prototype.showIndexComment = function() {
  return `<li>${this.author.name} : ${this.body}</li>`
}

Comment.prototype.showCommentMade = function () {
  return `<li>${this.type_object.name} (${this.commentable_type.split(/(?=[A-Z])/).join(" ")}) : ${this.body}</li>`
}

Comment.prototype.showCommentReceived = function () {
  //return `<li>${this.type_object.name} (${this.commentable_type.split(/(?=[A-Z])/).join(" ")}) : ${this.body}</li>`
}

Comment.done = function(response) {
  let $ul = $("div.comments ul");
  $ul.html(" ");
  $.each(response, function(index, value){
    let comment = new Comment(response[index]);
    let indexComment;
    if (this.id === "comments_made"){
      indexComment = comment.showCommentMade();
    }else if (this.id === "comments_received"){
      indexComment = comment.showCommentReceived();
    }else {
      indexComment = comment.showIndexComment();
    }
    $ul.append(indexComment);
  }.bind(this));
}

const loadCommentsMade = function () {
  $("#comments_made").on("click", function(e){
    $.get(this.href).done(Comment.done.bind(this))
    e.preventDefault();
  });
}

const loadComments = function() {
  $("#load_comments").on("click", function(e){
    e.preventDefault();
    $.get(this.href).done(Comment.done.bind(this))
  });  
}

const hideComments = function() {
  $("#hide_comments").on("click", function(e){
    let $ul = $("div.comments ul");
    $ul.html(" ")
    e.preventDefault();
  });
}

const newCommentForm = function() {
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
}

$(function(){
  loadComments();
  hideComments();
  newCommentForm();
  loadCommentsMade();
})

// $(function(){
//   $("#load_comments").on("click", function(e){
//     $.get(this.href).success(function(json){
//       let $ul = $("div.comments ul");
//       $ul.html(" ");
//       json.forEach(function(comment){
//         $ul.append("<li>" + comment.author.name + " : " + comment.body + "</li>")
//       });
//     });
//     e.preventDefault();
//   });
  //
  // $("#hide_comments").on("click", function(e){
  //   let $ul = $("div.comments ul");
  //   $ul.html(" ")
  //   e.preventDefault();
  // });
  // 
  // $("#new_comment").on("submit", function(e){
  //   $.ajax({
  //     type: ($("input[name='_method']").val() || this.method),
  //     url: this.action,
  //     data: $(this).serialize()
  //   }).success(function(response){
  //       $("#comment_body").val("");
  //       let $ul = $("div.comments ul");
  //       $ul.append(response);
  //     });
  //   e.preventDefault();
  // });

  // $("#comments_made").on("click", function(e){
  //   $.get(this.href).success(function(json){
  //     let $ul = $("div.comments ul");
  //     $ul.html(" ");
  //     json.forEach(function(comment){
  //       $ul.append("<li>" + comment.type_object.name + " (" + comment.commentable_type.split(/(?=[A-Z])/).join(" ") + ") : " + comment.body + "</li>")
  //     });
  //   });
  //   e.preventDefault();
  // });

  // $("#comments_received").on("click", function(e){
  //   $.get(this.href).success(function(json){
  //     let $ul = $("div.comments ul");
  //     $ul.html(" ");
  //     json.forEach(function(comment){
  //       $ul.append("<li>" + comment.author.name + " : " + comment.body + "</li>")
  //     });
  //   });
  //   e.preventDefault();
  // });
// });
  