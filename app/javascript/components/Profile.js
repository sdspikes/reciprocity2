import React from "react"
import PropTypes from "prop-types"
import NewProfileItem from "./NewProfileItem"
import PrivacyGroupSelector from "./PrivacyGroupSelector"

function hashify(arr) {
  return arr ?
    arr.reduce((h, item) => { h[item.id] = item; return h; }, {}) :
    arr
}

function getOptions (categories, profile_item_category_id, callback) {
  if (categories[profile_item_category_id].item_type !== "multi") return;
  // TODO: should this be changed to an api path?
  return fetch("/api/profile_item_categories/" + profile_item_category_id + "/options", {
      method: "GET", // *GET, POST, PUT, DELETE, etc.
      headers: {
          "Content-Type": "application/json",
      }
  })
  .then((response) => { return response.json()})
  .then((json_response) => {
    callback(json_response)
    // console.log(json)
  })
}

class Profile extends React.Component {
  constructor (props) {
    super(props);

    const profile_items = props.profile.profile_items;
    const item_data = props.profile.item_data;
    const categories = props.profile.categories;

    var category_hash = hashify(categories)
    var item_data_hash = hashify(item_data)

    this.state = {
      values: props.profile.values,
      profile_items: profile_items,
      item_data: item_data_hash,
      categories: category_hash,
      privacy_groups: hashify(props.profile.privacy_groups)
    };

    // grab options from backend for multi items
    if (this.props.editing) {
      categories.forEach((category) =>
        getOptions(category_hash, category.id, (json_response) => {
          this.updateOptions(category.id, json_response.options)
        }))
    }
  }

  render () {
    const { profile_items, item_data, categories, privacy_groups } = this.state;

    return (
      <React.Fragment>
        <div className="profile-box">
          <div className="profile-rhs">
            {profile_items.map((item, idx) => {
              const {profile_item_data_id, profile_item_category_id} = item;
              const data = item_data[profile_item_data_id]
              categories[profile_item_category_id].used = true
              const options = (categories[profile_item_category_id] && categories[profile_item_category_id].options) || []
              const { item_type, title } = categories[profile_item_category_id]

              return <div className="box" key={idx}>
                <span>{title}:&nbsp;</span>
                {!this.props.editing && <span>{data.value || ""}</span>}
                {this.props.editing &&
                  <span>
                    {item_type == "multi" &&
                      <select
                        value={data.value}
                        onChange={(e) => this.updateOption(item, idx, e.target.value, e.target)}>
                        {options.map((option) =>
                            <option key={option.id} id={option.id} value={option.value}>{option.value}</option>
                          )
                        }
                      </select>}
                    {(item_type == "text" || item_type == "number") &&
                      <input
                        value={data.value || ""}
                        onChange={(e) => this.updateText(item.id, profile_item_data_id, e.target.value)}/>}
                    <PrivacyGroupSelector item={item} privacy_groups={privacy_groups} />
                    <button onClick={(e) => this.deleteItem(item, idx)}>
                      Delete
                    </button>
                  </span>
                }
              </div>
            })}
            {this.props.editing &&
              <NewProfileItem
                categories={categories}
                callback={(a, b, c) => this.addItem(a, b, c)} />}
          </div>
        </div>
      </React.Fragment>
    );
  }

  deleteItem (item, item_index) {
    const {profile_items, categories} = this.state
    profile_items.splice(item_index, 1)
    categories[item.profile_item_category_id].used = false
    deleteProfileItem(item.id)
    this.setState({profile_items})
  }

  addItem (newItem, chosen_option, options) {
    const {profile_items, item_data, categories} = this.state;
    item_data[chosen_option.id] = chosen_option
    categories[newItem.profile_item_category_id].used = true

    if (options) {
      categories[newItem.profile_item_category_id].options = options
    }
    profile_items.push(newItem)
    this.setState({profile_items, item_data, categories})
  }

  updateText (profile_item_id, data_id, newValue) {
    let itemData = {...this.state.item_data};
    itemData[data_id].value = newValue
    this.setState({ item_data: itemData});
    sendTextValueUpdate(profile_item_id, data_id, newValue);
  }

  updateOption (item, item_index, newValue, target) {
    var index = target.selectedIndex;
    var optionElement = target.childNodes[index]
    var option_id =  Number.parseInt(optionElement.getAttribute('id'));

    const {categories, item_data, profile_items} = this.state;
    item_data[option_id] = categories[item.profile_item_category_id].options.find((option) => option_id === option.id);
    profile_items[item_index].profile_item_data_id = option_id;
    this.setState({item_data, profile_items});

    sendOptionValueUpdate(item.id, option_id);      
  }

  updateOptions (id, options) {
    const {categories} = this.state
    categories[id].options = options;
    this.setState({ categories: categories});
  }

}

// Profile.propTypes = {
//   greeting: PropTypes.string
// };
export default Profile;


function deleteProfileItem (profile_item_id) {
  return fetch("/profile_items/" + profile_item_id, {
      method: "DELETE", // *GET, POST, PUT, DELETE, etc.
      headers: {
          "Content-Type": "application/json",
      }
  })
  // .then((response) => {console.log(response.json())})
}



function sendOptionValueUpdate (profile_item_id, data_id) {
    return fetch("/profile_items/" + profile_item_id, {
        method: "PUT", // *GET, POST, PUT, DELETE, etc.
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({profile_item_data_id: data_id})
    })
    // .then((response) => {console.log(response.json())});
}


function sendTextValueUpdate (profile_item_id, data_id, value) {
    return fetch("/profile_items/" + profile_item_id, {
        method: "PUT", // *GET, POST, PUT, DELETE, etc.
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({profile_item_data_attributes: { id: data_id,  value: value }})
    })
    // .then((response) => {console.log(response.json())});
}