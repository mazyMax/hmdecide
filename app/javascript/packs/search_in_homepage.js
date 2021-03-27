// window.page_search=function(){
    
//     document.getElementById("searchResult").innerHTML = "Results";
//     var content = document.getElementById('search_bar').value;
//     var post_data = {keyword: content};

//     jQuery.ajax({
//         url: "/",
//         contentType: 'application/json;charset=UTF-8',
//         type: 'POST',
//         data: post_data,
//         dataType: "json",
//         async: false,
//         success: function (data) {
//             if (data != null){
//                 var div = document.getElementById('searchResult');
//                 for (var key in data){
//                     var detail = data[key];

//                     var  p = document.createElement( 'p' );
//                     p.innerHTML =  "<a href =" + "/shop_details/" + detail.shop_id + "> "
//                     + detail.shop_name + " in " + detail.location + " Score: "+ detail.average_rating + " Discount: " + detail.global_discount_ratio + "</a>";
//                     div.appendChild(p);
//                 }
//             }
//             else {
//                 alert("Shop does not sell anything or input information not found!")
//             }
//         },
//         fail: function (result) {
//             alert("Error");
//         }
//     });
    
// }