angular.module('reeder.controllers', []).
  controller('IndexController', function IndexController($scope, $cookies, $http) {
    var url = "/api/posts?api_token=" + $cookies.api_token;

    $http.get(url).success(function(resp) {
      $scope.page        = resp.page;
      $scope.total_pages = resp.total_pages;
      $scope.posts       = resp.records;
    });
  }).

  controller('FeedsController', function FeedsController($scope, $cookies, $http) {
    $scope.delete_feed = function(id) {
      $http.delete("/api/feeds/" + id + "?api_token=" + $cookies.api_token).
        success(function(data, status) {
          if (data.deleted) {
            alert('Deleted');
          }
        });
    };

    $http.get("/api/feeds?api_token=" + $cookies.api_token).success(function(resp) {
      $scope.feeds = resp;
    });
  }).

  controller('FeedController', function FeedController($scope, $http, $route, $cookies, $routeParams) {
    var feed_id = $routeParams.feed_id;
    var api_str = "?api_token=" + $cookies.api_token;

    $("a.feed").removeClass('active');
    $("a.feed[data-id=" + feed_id + "]").addClass('active');

    $http.get("/api/feeds/" + feed_id + api_str).success(function(resp) {
      $scope.feed = resp;

      $http.get("/api/feeds/" + feed_id + "/posts" + api_str).success(function(resp) {
        $scope.posts_count  = resp.total_entries;
        $scope.current_page = resp.page;
        $scope.posts        = resp.records;
      });
    });
  }).

  controller('ReederSidebarController', function SidebarController($scope, $http, $cookies) {
    $http.get('/api/feeds?api_token=' + $cookies.api_token).success(function(data) {
      $scope.feeds       = data;
      $scope.feeds_count = data.length;
    });
  }).

  controller('SigninController', function SigninController($scope, $cookies, $http) {
    $scope.authenticate = function() {
      var form = {
        email: $scope.email,
        password: $scope.password
      };

      $http.post('/api/authenticate', form).
        success(function(data, status) {
          console.log(data);
          $cookies.api_token = data.api_token;
        }).
        error(function(data, status) {
          alert('Invalid email or password');
        });
    }
  }).

  controller('FeedImportController', function FeedImportController($scope, $cookies, $http) {
    $scope.import_feed = function() {
      var url = prompt('Enter feed URL');
      
      var params = {
        api_token: $cookies.api_token,
        url: url
      };

      $http.post("/api/feeds/import", params).
        success(function(data, status) {
          console.log(data);
        });
    }
  }).

  controller('SignupController', function SignupController($scope, $http) {
    $scope.create_account = function() {
      var user = $scope.user;
      var form = {user: user};

      if (user.password != user.password_confirmation) {
        alert('Passwords do not match');
        return;
      }

      $http.post('/api/users', form).
        success(function(data, status) {
          alert('Account has been created!');
        }).
        error(function(data, status) {
          alert("Unable to create account: " + data.error);
        });
    }
  }).

  controller('FeedNavigationController', function FeedNavigationController($scope, $http) {
    $scope.view_full = function() {
      $("#main").removeClass('condensed');
      $("#view_full").addClass('active');
      $("#view_condensed").removeClass('active');
    }

    $scope.view_condensed = function() {
      $("#main").addClass('condensed');
      $("#view_condensed").addClass('active');
      $("#view_full").removeClass('active');
    }
  });