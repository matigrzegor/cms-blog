# Cms-blog
### Blog website with cms for managing content

## General Info

This rails application works together with this javascript client: https://github.com/michalgrzegor/cms-blog.  
  
Blog posts management sytem is built from scratch, using Quill as a WYSIWYG editor, and Delta as a format for
communication (https://quilljs.com/).  
  
Authentication is implemented using Devise.  
  
The OAuth 2.0 Authorization Framework is implemented using Doorkeeper (Authorization Code Grant is used to sign up
a user to the application).  
  
Link to blog: https://musing-ramanujan-8002a4.netlify.app  
Link to admin panel: https://musing-ramanujan-8002a4.netlify.app/auth  

## Technologies

- ruby 2.7.1
- rails 6.0.3
- postgresql
- devise
- doorkeeper
- active_storage
- textacular
