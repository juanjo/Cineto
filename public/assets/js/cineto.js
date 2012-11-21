$(function(){
  new BBSearch({
    url: "http://apify.ifc0nfig.com/tpb/search/#bbsearch-query#?$filter=category%20eq%20'Movies'&$top=10",
    inputElement: $("#search_input"),
    resultsElement: $("#results"),
    itemTemplate: '<a href="#add_torrent" onclick="add_torrent(\'<%= magnet %>\');"><h4><%= name %></h4></a>',
    onStart: function(){
      $("#results").slideUp( "fast" );
      $("#loading img").show();
    },
    onEnd: function( collection ){
      if( collection.length > 0 ) $("#results").slideDown( "slow" );
      $("#loading img").fadeOut( "fast" );
    },
  });
});

function add_torrent( torrent_uri ) {
  $("#torrent_uri_input").val( torrent_uri );
  $("#torrent_form").submit();
}
