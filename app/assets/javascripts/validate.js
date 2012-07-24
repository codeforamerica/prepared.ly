(function($,W,D)
{
    var JQUERY4U = {};
 
    JQUERY4U.UTIL =
    {
        setupFormValidation: function()
        {
            //form validation rules
            $("#new_contact").validate({
                rules: {
										name: "required",
                    body: "required",
                    email: {
                        required: true,
                        email: true
                    },  
                },
                messages: {
                   name: "Please include your name",
									 body: "Please include a message",
                   email: "Please enter a valid email address"
                },
                submitHandler: function(form) {
                    form.submit();
                }
            });
        }
    }
 
    //when the dom has loaded setup form validation rules
    $(D).ready(function($) {
        JQUERY4U.UTIL.setupFormValidation();
    });
 
})(jQuery, window, document);