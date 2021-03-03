from functools import wraps
from flask import request, abort

# The actual decorator function
def require_appkey(view_function):
    @wraps(view_function)
    # the new, post-decoration function. Note *args and **kwargs here.
    def decorated_function(*args, **kwargs):
        if request.headers.get('x-api-key') and request.headers.get('x-api-key') == "sua_app_key":
            return view_function(*args, **kwargs)
        else:
            abort(401)
    return decorated_function