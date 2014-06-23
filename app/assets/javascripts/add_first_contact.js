$(document).on("click", "#add_contact", function(event) 
{
  $.ajax({url: "/first_steps/add_contact",
          data: {"name": $("#name").val(), 
                 "email": $("#email").val(), 
                 "celphone": $("#celphone").val()},
          dataType : 'script' 
         });
});