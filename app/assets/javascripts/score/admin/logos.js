// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// Create variables (in this scope) to hold the API and image size
var jcrop_api, boundx, boundy;
var crop_x, crop_y, crop_w, crop_h;

function init_jcrop(x,y,w,h) {
  crop_x = x;
  crop_y = y;
  crop_w = w;
  crop_h = h;
  $('#target').Jcrop({
    onChange: updatePreview,
    onSelect: updatePreview,
    minSize: 100,
    maxSize: 200,
    aspectRatio: 1
  },function(){
    // Use the API to get the real image size
    var bounds = this.getBounds();
    boundx = bounds[0];
    boundy = bounds[1];
    // Store the API in the jcrop_api variable
    jcrop_api = this;
    jcrop_api.setSelect([crop_x,crop_y,crop_x+crop_w,crop_y+crop_h]);      
  });
  
}

function updatePreview(c)
{
  if (parseInt(c.w) > 0)
  {
    var rx = 100 / c.w;
    var ry = 100 / c.h;

    $('#thumb').css({
      width: Math.round(100 / c.w * boundx) + 'px',
      height: Math.round(100 / c.w * boundy) + 'px',
      marginLeft: '-' + Math.round(100 / c.w * c.x) + 'px',
      marginTop: '-' + Math.round(100 / c.w * c.y) + 'px'
    });
    $('#tiny').css({
      width: Math.round(50 / c.w * boundx) + 'px',
      height: Math.round(50 / c.w * boundy) + 'px',
      marginLeft: '-' + Math.round(50 / c.w * c.x) + 'px',
      marginTop: '-' + Math.round(50 / c.w * c.y) + 'px'
    });
    $('#micro').css({
      width: Math.round(25 / c.w * boundx) + 'px',
      height: Math.round(25 / c.w * boundy) + 'px',
      marginLeft: '-' + Math.round(25 / c.w * c.x) + 'px',
      marginTop: '-' + Math.round(25 / c.w * c.y) + 'px'
    });
    $('#logo_crop_h').val(c.h);
    $('#logo_crop_w').val(c.w);
    $('#logo_crop_y').val(c.y);
    $('#logo_crop_x').val(c.x);
  }
};
