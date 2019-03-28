(function() {

	//module
	angular.module("duckStatus", ["ngMap"]);

	//socket.io factory
	function socketFactory($rootScope) {
		var socket = io.connect("//ducks-to-db.mybluemix.net");
		return {
			on: function(eventName, callback) {
				socket.on(eventName, function () {
					var args = arguments;
					$rootScope.$apply(function () {
						callback.apply(socket, args);
					});
				});
			},
			emit: function (eventName, data, callback) {
				socket.emit(eventName, data, function () {
					var args = arguments;
					$rootScope.$apply(function () {
					if (callback) {
						callback.apply(socket, args);
					}
					});
				})
			},
			close: function() {
				socket.close();
			}
		};
	}

	socketFactory.$inject = ["$rootScope"];


	function duckStatusService($http, $q) {
		this.getAllStaticData = function() {
			var promises = [];

			var url = "/getCurrentHealthStatus";
			var request = $http.get(url);
			promises.push(request);

			url = "/getDevices";
			request = $http.get(url);
			promises.push(request);

			url = "/getDeviceObservations";
			request = $http.get(url);
			promises.push(request);

			url = "/getCivilianData";
			request = $http.get(url);
			promises.push(request);

			return $q.all(promises);
		};
	}

	duckStatusService.$inject = ["$http", "$q"];

	function duckStatusController(duckStatusService, $scope, $http, NgMap, socketFactory) {

		//when we leave this page, we want to make sure we unsubscribe from the socket endpoints
		$scope.$on("$destroy", function() {
			socketFactory.close();
		});

		$scope.healthStatusData = {};
		$scope.devices = [];
		$scope.deviceObservations = [];
		$scope.incomingMessages = [];
		$scope.civilianData = {};

		NgMap.getMap().then(function(map) {
			$scope.map = map;

			//we will retrieve current health status data here
			//and drop all of that into $scope.markerData
			duckStatusService.getAllStaticData().then(function(data) {
				//data[0] = healthStatusData
				//data[1] = devices
				//data[2] = deviceObservations

				var healthStatusData = data[0].data;
				//need to deconstruct this information and put it into a better format
				for(var i in healthStatusData) {
					var duckData = healthStatusData[i]["payload"]["Duck Data"];

					var duckId = duckData[0]["Duck ID"];
					var coordinates = duckData[0]["Coordinates"].split(",");
					var latitude = coordinates[0];
					var longitude = coordinates[1];
					var duckClass = duckData[0]["Class"];
					var timeOn = duckData[0]["Time on"];

					if(latitude > 0 && longitude > 0) {

						$scope.healthStatusData[duckId] = {
							"latitude": latitude,
							"longitude": longitude,
							"duckClass": duckClass,
							"timeOn": timeOnDisplayCalc(timeOn)
						};
					}
				}

				var deviceObservations = data[2].data;
				for(var i in deviceObservations) {
					var duckData = deviceObservations[i];

					var duckId = duckData["device_id"].split(",")[0];
					var latitude = duckData["latitude"];
					var longitude = duckData["longitude"];
					var duckClass = duckData["device_type"];
					var timeOn = 0;

					$scope.healthStatusData[duckId] = {
						"latitude": latitude,
						"longitude": longitude,
						"duckClass": duckClass,
						"timeOn": timeOn
					};

					console.log(duckId, latitude, longitude, duckClass);
				}

				var civilianData = data[3].data;
				for(var i in civilianData) {
					var id = civilianData[i]["uuid"];

					$scope.civilianData[id] = civilianData[i];
				}
			});
		});

		//connect to socket endpoints
		socketFactory.on("connect", function() {
			console.log("socket connected");
		});

		socketFactory.on("civilian", function(data) {
			var jsonData = JSON.parse(String(data));
			console.log("socket data", jsonData);
			$scope.incomingMessages.push(jsonData);

			var id = jsonData["uuid"];

			$scope.civilianData[id] = jsonData;
		});

		socketFactory.on("health", function(data) {
			var stringData = String(data);
			var jsonData = JSON.parse(stringData);
			console.log("health data socket", jsonData);
			$scope.incomingMessages.push(jsonData);

			var duckData = jsonData["Duck Data"];
			var duckId = duckData[0]["Duck ID"];
			var coordinates = duckData[0]["Coordinates"].split(",");
			var latitude = coordinates[0];
			var longitude = coordinates[1];
			var duckClass = duckData[0]["Class"];
			var timeOn = duckData[0]["Time on"];

			$scope.healthStatusData[duckId] = {
				"latitude": latitude,
				"longitude": longitude,
				"duckClass": duckClass,
				"timeOn": timeOnDisplayCalc(timeOn)
			};
		});

		$scope.googleMapsUrl = "https://maps.googleapis.com/maps/api/js?key=AIzaSyAwpA8PHX57_8RCU8iCCDdIEViCWrpy44k";

		$scope.markerClicked = function(event, id) {
			var selectedItem = $scope.healthStatusData[id];

			if(selectedItem != undefined && selectedItem != null) {
				selectedItem.id = id;
				$scope.selectedDuck = selectedItem;
				$scope.map.showInfoWindow("duckInfo", this);
			}

		};

		$scope.visualizeDataPath = function(key) {
			$scope.shapePath = [];
			var path = $scope.civilianData[key].payload.path;

			if(path != undefined && path != null && path.length > 0) {
				var pathSplit = path.split(",");

				//we can't draw lines to only one point
				if(pathSplit.length > 1) {
					for(var i in pathSplit) {
						var thisPath = pathSplit[i];

						if(thisPath != undefined && thisPath != null && thisPath.length > 0) {
							//lookup the coordinates to this device ID
							var device = $scope.healthStatusData[thisPath];
							console.log(device);

							if(device != undefined && device != null) {
								var item = [device.latitude, device.longitude];
								$scope.shapePath.push(item);
							}
						}
					}
				}
			}


		};

		function timeOnDisplayCalc(timeInMilliseconds) {
			var timeOnSeconds = Math.floor((timeInMilliseconds / 1000) % 60);
			var timeOnMinutes = Math.floor((timeInMilliseconds / (1000 * 60)) % 60);
			var timeOnHours = Math.floor((timeInMilliseconds / (1000 * 60 * 60)) % 24);

			return timeOnHours + "h, " + timeOnMinutes + "m, " + timeOnSeconds + "s";
		}

	}

	duckStatusController.$inject = ["duckStatusService", "$scope", "$http", "NgMap", "socketFactory"];

	angular.module("duckStatus").factory("socketFactory", socketFactory).service("duckStatusService", duckStatusService).controller("duckStatusController", duckStatusController);

})();
