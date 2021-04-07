
window.getLocation =function()
{
    if (navigator.geolocation)
    {
    return navigator.geolocation.getCurrentPosition(showPosition);
    }
    else{return ""}
}
window.showPosition = function (position)
{
    var lng = position.coords.longitude;
    var lat = position.coords.latitude;
    var site = lat.toFixed(6)+','+lng.toFixed(6);
    return site;
    // console.log(site)
    //    document.getElementById("demo").innerHTML = site;
}
