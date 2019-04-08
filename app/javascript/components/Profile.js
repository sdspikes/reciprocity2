import React from "react"
import PropTypes from "prop-types"


function hashify(arr) {
    return arr.reduce((h, item) => { h[item.id] = item; return h; }, {})
}

var privacyStyle = {
  float: 'right'
};


function sendPrivacyGroupUpdate (profile_item_id, privacy_group_id) {
    return fetch("/profile_items/" + profile_item_id, {
        method: "PUT", // *GET, POST, PUT, DELETE, etc.
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({privacy_group_id: privacy_group_id})
    })
    // .then((response) => {console.log(response.json())});
}


class PrivacyGroupSelector extends React.Component {
  constructor (props) {
    super()
    const privacy_groups = props.privacy_groups
    privacy_groups[0] = {name: "All Connections"}
    privacy_groups[-1] = {name: "Only Me"}

    this.state = {
      item: props.item,
      privacy_groups: privacy_groups,
    }
  }

  updatePrivacyGroup(privacy_group_id) {
    const {item} = this.state
    item.privacy_group_id = privacy_group_id
    sendPrivacyGroupUpdate(item.id, privacy_group_id)
    this.setState({ item: item })
  }

  render () {
    const {privacy_groups, item} = this.state
    const id = item.privacy_group_id ? item.privacy_group_id : 0
    return <span style={privacyStyle}>
      Privacy Group:&nbsp;
      <select
        value={id}
        onChange={(e) => this.updatePrivacyGroup(e.target.value)}>
        {Object.keys(privacy_groups).map((id) => {
            return <option key={id} value={id}>{privacy_groups[id].name}</option>
          })
        }
      </select>
    </span>
  }
}

class NewProfileItem extends React.Component {
  constructor (props) {
    super(props);

    this.state = {
      categories: props.categories,
      selected_category_id: Object.keys(props.categories)[0],
      editing: false,
      new_item: null,
      options: [],
    }
  }

  render () {
    const {editing, categories, selected_category_id} = this.state
    if (!editing) {
      return <span id="new_item">
        <select
          value={selected_category_id}
          onChange={(e) => this.updateCategoryId(e.target.value)}>
          {Object.keys(categories).map((id) =>
              <option key={id} id={id} value={id}>{categories[id].title}</option>
            )
          }
        </select>
        <button onClick={(e) => this.createNewItem()}>
          Create new profile item
        </button>
      </span>
    }

    const {new_item} = this.state

    const { item_type, title, data } = categories[selected_category_id]
    const options = (categories[selected_category_id] && categories[selected_category_id].options) || []

    return <div className="box">
      <span>{title}:&nbsp;</span>
        {item_type == "multi" && <select
            value={new_item.profile_item_data_id}
            onChange={(e) => this.updateValue(e.target)}>
            {options.map((option) =>
                <option key={option.id} id={option.id} value={option.id}>{option.value}</option>
              )
            }
          </select>
        }
    </div>;
  }
  updateValue (target) {
    var index = target.selectedIndex;
    var optionElement = target.childNodes[index]
    var option_id =  Number.parseInt(optionElement.getAttribute('id'));


    const {new_item} = this.state
    new_item.profile_item_data_id = option_id
    this.setState({
      new_item: new_item
    })
    console.log(this.state)

  }
//this.updateOption(item, -1, e.target.value, e.target)}>
        // <PrivacyGroupSelector item={item} privacy_groups={privacy_groups} />
  updateCategoryId (id) {
    this.setState({selected_category_id: id})
  }

  createNewItem () {
    const {selected_category_id, categories} = this.state

    this.setState({
      new_item: {
        profile_item_category_id: selected_category_id
      },
      editing: true
    })

    // profile_items.push({profile_item_category_id: selected_category_id})
  }
}

function getOptions (categories, profile_item_category_id, callback) {
  console.log(categories, profile_item_category_id)
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
    // console.log(this.state.profile_items)
    // console.log(this.state.item_data)
    // console.log(this.state.categories)

    // grab options from backend for multi items
    if (this.props.editing) {
      categories.forEach((category) =>
        getOptions(category_hash, category.id, (json_response) => {
          this.updateOptions(category.id, json_response.options)
        }))
    }
  }

  render_item (item, idx) {
    const { profile_items, item_data, categories, privacy_groups, selected_category_id } = this.state;
    // const {item_type, title, displayName, options} = field;
    const {profile_item_data_id, profile_item_category_id} = item;
    const { item_type, title } = categories[profile_item_category_id]
    const data = item_data[profile_item_data_id]
    const options = (categories[profile_item_category_id] && categories[profile_item_category_id].options) || []

    if (item_type == "multi") {
      return <div className="box" key={idx}>
          <span>{title}:&nbsp;</span>
          {this.props.editing && data.value ?
            <span>
              <select
                value={data.value}
                onChange={(e) => this.updateOption(item, idx, e.target.value, e.target)}>
                {options.map((option) =>
                    <option key={option.id} id={option.id} value={option.value}>{option.value}</option>
                  )
                }
              </select>
              <PrivacyGroupSelector item={item} privacy_groups={privacy_groups} />
            </span> :
          <span>{data.value || ""}</span>}
        </div>;
    } else if (item_type == "text") {
      return <div className="box" key={idx}>
          <span>{title}:&nbsp;</span>
          {this.props.editing ?
            <span>
              <input
                value={data.value || ""}
                onChange={(e) => this.updateText(item.id, profile_item_data_id, e.target.value)}/> 
              <PrivacyGroupSelector item={item} privacy_groups={privacy_groups} />
            </span> :
          <span>{data.value || "??"}</span>}
        </div>;
    } else {
      return <p>Error: you tried to render a field with invalid type: {item_type}</p>;
    }
  }


  render () {
    const { profile_items, item_data, categories, privacy_groups, selected_category_id } = this.state;
    const selected_category = categories[selected_category_id]
    return (
      <React.Fragment>
        <div className="profile-box">
          <div className="profile-rhs">
            {profile_items.map((item, idx) => this.render_item(item, idx))}
            <NewProfileItem categories={categories} />
          </div>
        </div>
      </React.Fragment>
    );
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
    console.log(optionElement)
    console.log(newValue)
    var option_id =  Number.parseInt(optionElement.getAttribute('id'));

    let profileItems = this.state.profile_items
    let itemData = {...this.state.item_data};
    console.log(itemData, option_id, item)
    const {categories} = this.state;
    itemData[option_id] = categories[item.profile_item_category_id].options.find((option) => option_id === option.id);
    profileItems[item_index].profile_item_data_id = option_id;
    this.setState({ item_data: itemData, profile_items: profileItems});

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

function newProfileItem (profile_item_category_id, data_id) {
    return fetch("/profile_items", {
        method: "POST", // *GET, POST, PUT, DELETE, etc.
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({
          profile_item_category_id: profile_item_category_id,
          profile_item_data_id: data_id
        })
    })
    // .then((response) => {console.log(response.json())});
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