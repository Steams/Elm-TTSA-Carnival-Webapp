
X_DOMAINS = '*'
X_HEADERS = ['Authorization','Content-type']

MONGO_HOST = 'localhost'
MONGO_PORT = 27017


MONGO_DBNAME = 'ttsaCarnival'

RESOURCE_METHODS = ['GET', 'POST', 'DELETE']
ITEM_METHODS = ['GET', 'DELETE']

schema = {
    'name': {
        'type': 'string',
        'required': True
    }
    , 'additional': {
        'type': 'string',
    }
    , 'email': {
        'type': 'string',
        'required': True
    }
    , 'size': {
        'type': 'string',
    }
    , 'gender': {
        'type': 'string',
    }
    , 'color': {
        'type': 'string',
    }
}

orders = {
    # 'title' tag used in item links. Defaults to the resource title minus
    # the final, plural 's' (works fine in most cases but not for 'people')
    #'item_title': 'person',

    # by default the standard item entry point is defined as
    # '/people/<ObjectId>'. We leave it untouched, and we also enable an
    # additional read-only entry point. This way consumers can also perform
    # GET requests at '/people/<lastname>'.
    'additional_lookup': {
        'url': 'regex("[\w]+")',
        'field': 'name'
    },

    # We choose to override global cache-control directives for this resource.
    'cache_control': 'max-age=10,must-revalidate',
    'cache_expires': 10,

    # most global settings can be overridden at resource level
    'resource_methods': ['GET', 'POST'],

    'schema': schema
}


DOMAIN = {'orders': orders}
