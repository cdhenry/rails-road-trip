// const setAttributes = function (id){
//   $(".js-next").attr("data-id", id);
//   $(".js-previous").attr("data-id", id);
//   $(".js-page-count").text(`(${id + 1})`)
// }

const getNext = function(getObject){
  $(".js-next").on("click", function(e) {
    let total = parseInt($(".js-next").attr("data-total"))
    let id = parseInt($(".js-next").attr("data-id"))
    if (total > id){
      var nextId = id + 1;
      getObject(nextId);
    }
    e.preventDefault();
  });
}

const getPrevious = function(getObject){
  $(".js-previous").on("click", function(e) {
    if (-1 < parseInt($(".js-previous").attr("data-id"))){
      var previousId = parseInt($(".js-previous").attr("data-id")) - 1;
      getObject(previousId);
    }
    e.preventDefault();
  });
}
