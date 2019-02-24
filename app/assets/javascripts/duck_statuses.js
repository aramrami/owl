(function() {

	//module
	angular.module("duckStatus", ["ngMap"]);


	function duckStatusService($http) {
		this.testData = [
			{id: 1234, batteryLevel: 50, position: [18.350704, -66.047446]},
			{id: 1235, batteryLevel: 10, position: [18.340704, -66.037446]},
			{id: 1236, batteryLevel: 50, position: [18.330704, -66.027446]},
			{id: 1237, batteryLevel: 50, position: [18.320704, -66.017446]},
			{id: 1238, batteryLevel: 50, position: [18.310704, -66.047446]},
			{id: 1239, batteryLevel: 50, position: [18.300704, -66.037446]},
			{id: 1240, batteryLevel: 50, position: [18.290704, -66.027446]},
			{id: 1241, batteryLevel: 50, position: [18.280704, -66.017446]},
			{id: 1242, batteryLevel: 50, position: [18.270704, -66.007446]},
			{id: 1243, batteryLevel: 50, position: [18.260704, -66.097446]},
			{id: 1244, batteryLevel: 50, position: [18.250704, -66.087446]},
			{id: 1245, batteryLevel: 50, position: [18.240704, -66.077446]},
			{id: 1246, batteryLevel: 50, position: [18.230704, -66.067446]},
			{id: 1247, batteryLevel: 50, position: [18.220704, -66.057446]},
			{id: 1248, batteryLevel: 50, position: [18.210704, -66.047446]},
			{id: 1249, batteryLevel: 50, position: [18.200704, -66.037446]},
			{id: 1250, batteryLevel: 50, position: [18.190704, -66.027446]},
			{id: 1251, batteryLevel: 50, position: [18.180704, -66.017446]},
			{id: 1252, batteryLevel: 50, position: [18.170704, -66.007446]},
			{id: 1253, batteryLevel: 50, position: [18.160704, -66.097446]},
			{id: 1254, batteryLevel: 50, position: [18.150704, -66.087446]},
			{id: 1255, batteryLevel: 50, position: [18.140704, -66.077446]}
		];
	}

	duckStatusService.$inject = ["$http"];

	function duckStatusController(duckStatusService, $scope, $http, NgMap) {

		NgMap.getMap().then(function(map) {
			$scope.map = map;
		});

		$scope.markerData = duckStatusService.testData;

		$scope.googleMapsUrl = "https://maps.googleapis.com/maps/api/js?key=AIzaSyAwpA8PHX57_8RCU8iCCDdIEViCWrpy44k";

		$scope.markerClicked = function(event, id) {
			var selectedItem = $scope.markerData.filter(function (item) {
				return item.id == id;
			});

			if(selectedItem.length > 0) {
				$scope.selectedDuck = selectedItem[0];
				$scope.map.showInfoWindow("duckInfo", this);
			}

		};

	}

	duckStatusController.$inject = ["duckStatusService", "$scope", "$http", "NgMap"];

	angular.module("duckStatus").service("duckStatusService", duckStatusService).controller("duckStatusController", duckStatusController);

})();
