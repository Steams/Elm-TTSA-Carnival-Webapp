var express     =   require("express");
var app         =   express();
var bodyParser  =   require("body-parser");
var router      =   express.Router();
var mongoose    =   require("mongoose");

mongoose.connect('mongodb://localhost:27017/ttsa');
var db = mongoose.connection;

db.on('error', console.error.bind(console, 'connection error:'));

db.once('open', function (callback) {

	var OrderSchema = mongoose.Schema({
		name: String,
		additional: String,
		email: String,
    size: String,
    color: String,
    package_name: String
	});

	var Order = mongoose.model('Order',OrderSchema);

  app.use(bodyParser.json());
  // app.use(bodyParser.urlencoded({"extended" : false}));
	// app.use(bodyParser.urlencoded({
	// 	extended:true
	// }));

	app.use(function (req, res, next) {
		// Website you wish to allow to connect
		res.setHeader('Access-Control-Allow-Origin', '*');

		// Request methods you wish to allow
		res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');

		// Request headers you wish to allow
		res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');

		// Set to true if you need the website to include cookies in the requests sent
		// to the API (e.g. in case you use sessions)
		res.setHeader('Access-Control-Allow-Credentials', true);

		// Pass to next layer of middleware
		next();
	});

	app.post('/orders',function(req,res){
		console.log(req.body);
		var m = new Order({
			name: req.body.name,
			additional: req.body.additional,
			email: req.body.email,
      size: req.body.size,
      gender: req.body.gender,
      color: req.body.color,
      package_name: req.body.package_name
		});
		m.save(function(err,el,affected){
			res.send(el);
		});
	});

    app.get('/orders',function(req,res){
        console.log("get orders");
        Order.find({},function(err,data){
            // Mongo command to fetch all data from collection.
            if(err) {
                response = {"error" : true,"message" : "Error fetching data"};
            } else {
                response = {"error" : false,"message" : data};
            }
            res.json(response);
        })});

	  app.get('/',function(req,res){
		    res.send("Hello world");
	  });


	app.listen(5000);

});


