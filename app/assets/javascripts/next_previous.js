const setAttributes = function (id){
  $(".js-next-tag").attr("data-id", id);
  $(".js-previous-tag").attr("data-id", id);
}

const getNext = function(getObject(), nextId){
  $(".js-next-tag").on("click", function(e) {
    let total = parseInt($(".js-next-tag").attr("data-total"))
    let id = parseInt($(".js-next-tag").attr("data-id"))
    if (total > id){
      var nextId = id + 1;
      getObject(nextId);
    }
    e.preventDefault();
  });
}

const getPrevious = function(){
  $(".js-previous-tag").on("click", function(e) {
    if (-1 < parseInt($(".js-previous-tag").attr("data-id"))){
      var previousId = parseInt($(".js-previous-tag").attr("data-id")) - 1;
      getTag(previousId);
    }
    e.preventDefault();
  });
}
