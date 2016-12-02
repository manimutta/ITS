var SearchFilter = {
	services_data: {}
};

SearchFilter.init = function(){
	this.initHandlers();
	var formData = SearchFilter.getFormData($('form[name=search-filter]'));
	this.getServiceData(formData)
}.bind(SearchFilter);


SearchFilter.initHandlers = function(){

	// CATEGORY CHAGNGE
	$('form[name=search-filter] select[name=category]').change(function(){
		SearchFilter.getActivities($('form[name=search-filter] select[name=category]').val());
	});

	// LOCATION/ACTIVITIES CHANGE
	$('form[name=search-filter]').on('change', 'input', function(e){
		var formData = SearchFilter.getFormData($('form[name=search-filter]'));
		SearchFilter.getServiceData(formData)
	});

	$('.service-providers-listing').on('change', 'input',function(e){
		var a = $(e.target).val()
		$('span[data-id='+$(e.target).attr("data-id")+']').empty()
		$('span[data-id='+$(e.target).attr("data-id")+']').html(a)
	})
}.bind(SearchFilter);

SearchFilter.popUpNotification =function(){

}.bind(SearchFilter)

SearchFilter.getServiceData = function(data){
	$.ajax({
		method: "get",
		url: "/services/search",
		data: data,
		success: function(msg){
			$('.service-providers-listing').html(msg);
		}
	});
}.bind(SearchFilter)

SearchFilter.getActivities = function(e){
	$.ajax({
		  method: "get",
		  url: "/services/category",
		  data: {id: e}
		}).done(function(msg){
			SearchFilter.updateActivities(msg)
		});
}.bind(SearchFilter);

SearchFilter.getFormData = function($form){
    var unindexed_array = $form.serializeArray();
    var indexed_array = {zones: [], activities: [], category: []};
    $.map(unindexed_array, function(n,i){
    	indexed_array[n['name']].push(n['value'])
    })
    return indexed_array;
}.bind(SearchFilter);

SearchFilter.updateActivities = function(msg)
{
	$(".activities_div").empty();
	data = msg["data"];
	for(x=0; x<msg["data"].length; x++){
		$( ".activities_div" ).append( '<div class="col-md-6"><div class="form-group"><div class="checkbox"><label class="activity_inputs"><input type="checkbox" name="activities" value="' +data[x]["id"]+'"><span class="checkbox-material"></span>' +" " + data[x]["name"] + '</label></div></div></div>' );	
	}
	$.material.init();
}.bind(SearchFilter);
SearchFilter.getService = function( service_id, provider_id ,sub_category){
  var data = {"provider_id": provider_id, "sub_category": sub_category}
  $.ajax({
    method: "get",
    url: "/services/get_service",
    data: data,
    success: function(msg){
      $('*[data-service='+service_id+']').first().replaceWith(msg);
    }
  });

}.bind(SearchFilter);



var EnquireNow ={};

$(function(){
	EnquireNow.init();
});


EnquireNow.init = function(){
	this.initHandlers();
}.bind(EnquireNow);


EnquireNow.initHandlers = function(){
	$('.service_for').on('change', 'input', function(e){
	$('.child-select-div').toggle();
	});
}.bind(EnquireNow);

