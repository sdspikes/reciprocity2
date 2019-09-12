var Helpers = {
  hashify: function(arr, attr = "user_id") {
    return arr.reduce((h, item) => {
      h[item[attr]] = item;
      return h;
    }, {})
  }
}

export default Helpers;