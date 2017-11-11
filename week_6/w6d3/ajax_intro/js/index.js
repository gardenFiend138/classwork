console.log("Hello from the JavaScript console!");

// Your AJAX request here
$.ajax({
  type: 'GET',
  url: "http://api.openweathermap.org/data/2.5/forecast?id=" +
       "5393068&APPID=2461687fceb241a8bf261d11dcbb626f",
  success(data) {
    console.log('We have your weather!')
    console.log(data);
  },
  error() {
    console.error('An error has occured.');
  }
})
// Add another console log here, outside your AJAX request
console.log('This is a second print statement to see order of execution.');
