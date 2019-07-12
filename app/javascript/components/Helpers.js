var Helpers = {
  hashify: function(arr) {
    return arr.reduce((h, item) => {
      h[item.user_id] = item;
      return h;
    }, {})
  }
}

export default Helpers;