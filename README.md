## Product Boilerplate

- To Install: `npm install`
- To Test: `npm test`
- To start: `npm run-script build` and the server will be on port `9090`

### Resources

Each resource (every noun in your system, ie: user, comment, video, etc.) that you would like to be exposed should have a folder within the `server/resources` (non-plural, pluralizatin is done automatially).

For the these examples, we will use the resource `thread` in the folder `server/resources/thread` as our example.

#### Resource Format

Each resource handler should be a function that takes three arguments.

```coffee
module.exports = (user, opt, cb) ->
  # do stuff
```

1. The first argument (`user`) is the currently logged in user. If the request does not have an assosciated user, this will be null.
2. The second argument (`opt`) is an object that contains the following attributes.
  - `data` (optional) - any raw, unprocessed data from the request (typically `req.body`).
  - `options` (optional) - any options for the request (typically `req.query`)
  - `id` (optional) - a unique ID for the request (typically from `req.params`)
3. The third argument (`cb`) is a standard node-style callback that takes two arguments
  - `err` can be a standard `Error` object, or an object like `{status: 403, message: 'Not authorized'}`
    - Note: Error status codes always default ro 500, to change this provide a status key in the error object.
  - `data` can be any data to send down to the user.
    - Note: This data should always be sanitized based on the `user` argument to the resource.
    - Note: This data should be JSON serializable as it is passed to JSON.stringify

#### HTTP Verbs

These are the standard file names, what they do, and what HTTP endpoint they will expose

- findById = GET /threads/12345
  - Operation: Look up a resource by a unique ID
- replaceById = PUT /threads/12345
  - Operation: Completely replace a resource by a unique ID
  - Tip: Use the body (`opt.data` for the contents of the new resource)
- modifyById = PATCH /threads/12345
  - Operation: Merge new data into a resource by a unique ID
  - Tip: Use the body (`opt.data` for the contents to be merged into the existing resource)
- find = GET /threads
  - Operation: Look up a set of a resource
  - Tip: Use querystring params (`opt.options`) to limit, filter, sort, etc.
- create = POST /threads
  - Operation: Create a new resource
  - Tip: Use the body (`opt.data` for the contents of the resource)
