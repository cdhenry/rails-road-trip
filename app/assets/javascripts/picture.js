$(function(){
  $(".js-next-pic").on("click", function(e) {
    $.get(this.href).success(function(data) {
      var counter = parseInt($(".js-next-pic").attr("data-id")) + 1;
      if (counter < data.length){
        $(".image_url")[0].src = data[counter]["url"] + new Date().getTime();
        // re-set the id to current on the link
        $(".js-next-pic").attr("data-id", counter);
        $(".js-previous-pic").attr("data-id", counter);
        $(".js-page-count").text(`(${counter + 1})`)
      }else {
        counter = parseInt($(".js-next-pic").attr("data-id")) - 1;
      }
    });
    e.preventDefault();
  });

  $(".js-previous-pic").on("click", function(e) {
    $.get(this.href).success(function(data) {
      var counter = parseInt($(".js-previous-pic").attr("data-id")) - 1;
      if (counter > -1){
        $(".image_url")[0].src = data[counter]["url"] + new Date().getTime();
        // re-set the id to current on the link
        $(".js-next-pic").attr("data-id", counter);
        $(".js-previous-pic").attr("data-id", counter);
        $(".js-page-count").text(`(${counter + 1})`)
      }else {
        counter = parseInt($(".js-previous-pic").attr("data-id")) + 1;
      }
    });
    e.preventDefault();
  });
});

// function Pictures(pictures) {
//   let ids = [];
//   pictures.forEach(function(picture, index){
//     ids[index] = picture.id
//   })
//   this.ids = ids;
// }
//
// function Picture(picture){
//   this.id = picture.id;
//   this.url = picture.url;
//   this.imageable_id = picture.imageable_id;
//   this.imageable_type = picture.imageable_type;
// }
//
// Picture.prototype.uncachedImgUrl = function (){
//   return this.url + new Date().getTime();
// }
//
// Pictures.done = function(response) {
//   debugger;
//   return new Pictures(response);
// }
//
// Picture.done = function(response) {
//   let picture = new Picture(repsonse);
//   $(".image_url")[0].src = picture.uncachedImgUrl();
// }
//
// const getPictures = function(){
//   let json = $(".js-next")[0].pathname
//   $.get(json).done(Pictures.done);
// }
//
// const getPicture = function(id){
//   let json = $(".js-next")[0].pathname
//   $.get(json).done(Picture.done);
//   setAttributes(id);
// }
//
// $(function(){
//   getPictures();
//   getNext(getPictures(pictures.ids));
//   getPrevious(getPictures(pictures.ids));
// })
