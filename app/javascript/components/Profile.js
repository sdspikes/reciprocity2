import React from "react"
import PropTypes from "prop-types"


// const fields = {

// }

const fields = [
    { item_type: "multi",
      title: "gender",
      displayName: "Gender",
      options: [
        { name: "male" },
        { name: "female" },
        { name: "nonbinary" },
      ]
    },
    { item_type: "multi",
      title: "relationship_style",
      displayName: "Relationship style",
      options: [
        { name: "solo poly" },
        { name: "hierarchical poly" },
        { name: "mono" },
      ]
    },
    { item_type: "multi",
      title: "current_relationships",
      displayName: "Current relationships",
      options: [
        {name :"primary"},
        {name :"primary and secondaries"},
        {name :"multiple non-hierarchical"},
        {name :"seeking primary"}
      ]
    }
  ]

function hashify(arr) {
    return arr.reduce((h, item) => { h[item.id] = item; return h; }, {})
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
      categories: category_hash
    };
    // console.log(this.state.profile_items)
    // console.log(this.state.item_data)
    // console.log(this.state.categories)

    // grab options from backend for multi items
    if (this.props.editing) {
      profile_items.forEach((item, idx) => this.getOptions(item, idx))
    }
  }

  render () {
    const privacyGroups = ["all", "friends"];
    const { profile_items, item_data, categories } = this.state;

    const fakePrivacyGroup = <p><small>Privacy group:</small>&nbsp;
        <select>
          {privacyGroups.map((x, idx) => <option key={idx} value={x}>{x}</option>)}
        </select>
      </p>;


    return (
      <React.Fragment>
        <div className="profile-box">
          <div className="profile-rhs">
            {profile_items.map((item, idx) => {
              // const {item_type, title, displayName, options} = field;
              const {profile_item_data_id, profile_item_category_id} = item;
              const { item_type, title } = categories[profile_item_category_id]
              const data = item_data[profile_item_data_id]
              const options = item.options || []

              if (item_type == "multi") {
                return <div className="box" key={idx}>
                    <span>{title}:&nbsp;</span>
                    {this.props.editing && data.value ?
                      <select
                        value={data.value}
                        onChange={(e) => this.updateOption(item, idx, e.target.value, e.target)}>
                        {options.map((option) =>
                            <option key={option.id} id={option.id} value={option.value}>{option.value}</option>
                          )
                        }
                      </select> :
                    <span>{data.value || ""}</span>}
                  </div>;
              } else if (item_type == "text") {
                return <div className="box" key={idx}>
                    <span>{title}:&nbsp;</span>
                    {this.props.editing ?
                      <input
                        value={data.value || ""}
                        onChange={(e) => this.updateText(item.id, profile_item_data_id, e.target.value)}/> :
                    <span>{data.value || "??"}</span>}
                  </div>;
              } else {
                return <p>Error: you tried to render a field with invalid type: {item_type}</p>;
              }
            })}
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
    var option_id =  Number.parseInt(optionElement.getAttribute('id'));

    let profileItems = this.state.profile_items
    let itemData = {...this.state.item_data};
    itemData[option_id] = item.options.find((option) => option_id === option.id);
    profileItems[item_index].profile_item_data_id = option_id;
    this.setState({ item_data: itemData, profile_items: profileItems});

    sendOptionValueUpdate(item.id, option_id);
  }

  getOptions (profile_item, index) {
    if (this.state.categories[profile_item.profile_item_category_id].item_type !== "multi") return;
    // TODO: should this be changed to an api path?
    return fetch("/api/profile_item_categories/" + profile_item.profile_item_category_id + "/options", {
        method: "GET", // *GET, POST, PUT, DELETE, etc.
        headers: {
            "Content-Type": "application/json",
        }
    })
    .then((response) => { return response.json()})
    .then((json) => {
      // console.log(json)
      this.updateOptions(index, profile_item, json.options)
    })
  }

  updateOptions (index, profile_item, options) {
    let profileItems = this.state.profile_items
    profileItems[index].options = options;
    this.setState({ profile_items: profileItems});
    // this.forceUpdate();
  }

}

// Profile.propTypes = {
//   greeting: PropTypes.string
// };
export default Profile;

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