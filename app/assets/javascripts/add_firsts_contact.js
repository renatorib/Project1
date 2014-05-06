$(document).on("click", "#add_contact", function(event) 
{
  $.ajax({url: "/first_steps/add_contact",
          data: define_params,
          success: function(data)
                   {
                     $('#contacts_list').html(data);   
                     $("#name").val("");
                     $("#email").val("");
                     $("#celphone").val("");  
                   },
          statusCode: {422: function(data)
                            { 
                              console.log(data);
                              alert($.parseJSON(data));
                              $("#name").parent().addClass("has-error");
                            }
                      }
         });
});

define_params = function(){
  return {"name": $("#name").val(), 
          "email": $("#email").val(), 
          "celphone": $("#celphone").val()};
}