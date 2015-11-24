$(function () {
  $('form').on('submit', function (e) {
    e.preventDefault();
    $.ajax({
      type: "post",
      url: "/process",
      data: $("form").serialize(),
      success: function (data) {
        data = JSON.parse(data);
        $("#console").append("<br>" + "> " + data["input"] + "<br>" + data["output"] + "<br>");
        $("#console").scrollTop($("#console")[0].scrollHeight);
      }
    });
  });
});
