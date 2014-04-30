$(document).on("click", "#add_contact", function(event) 
{
  if ($("#name").val() != "") {
    $.ajax({url: "/first_steps/add_contact",
            data: {"name": $("#name").val(), 
                   "email": $("#email").val(), 
                   "celphone": $("#celphone").val()},
            success: function(data) 
            { 
              $('#contacts_list').html(data); 
              $("#name").val("");
              $("#email").val("");
              $("#celphone").val("");
            }
           });
  };
});