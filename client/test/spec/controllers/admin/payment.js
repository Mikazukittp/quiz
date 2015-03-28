'use strict';

describe('Controller: AdminPaymentCtrl', function () {

  // load the controller's module
  beforeEach(module('clientApp'));

  var AdminPaymentCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    AdminPaymentCtrl = $controller('AdminPaymentCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
