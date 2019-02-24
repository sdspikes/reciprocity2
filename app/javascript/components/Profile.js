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
      profile_items: props.profile.profile_items,
      item_data: item_data_hash,
      categories: category_hash
    };
    console.log(this.state.profile_items)
    console.log(this.state.item_data)
    console.log(this.state.categories)

    // TODO: for multi, grab options from backend
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
          <div className="profile-lhs">
            <div>
              <Bio
                editing={this.props.editing}
                value={this.state.values.bio}
                onChange={(x) => this.updateValue("bio", x)} />
            </div>
          </div>
          <h4>Info</h4>
          <div className="profile-rhs">
            {profile_items.map((item, idx) => {
              // const {item_type, title, displayName, options} = field;
              const {profile_item_data_id, profile_item_category_id} = item;
              const { item_type, title } = categories[profile_item_category_id]
              const data = item_data[profile_item_data_id]
              const options = []

              if (item_type == "multi") {
                return <div className="box" key={idx}>
                    <span>{title}:&nbsp;</span>
                    {this.props.editing ?
                      <select
                        value={this.state.values[title] || ""}
                        onChange={(e) => this.updateValue(profile_item_data_id, e.target.value)}>
                        <option value=""/>
                        {options.map((option, idx) =>
                            <option key={idx} value={option.name}>{option.name}</option>
                          )
                        }
                      </select> :
                    <span>{data.value || "??"}</span>}
                  </div>;
              } else if (item_type == "text") {
                return <div className="box" key={idx}>
                    <span>{title}:&nbsp;</span>
                    {this.props.editing ?
                      <input
                        value={data.value || ""}
                        onChange={(e) => this.updateText(profile_item_data_id, e.target.value)}/> :
                    <span>{data.value || "??"}</span>}
                  </div>;
              } else {
                return <p>Error: you tried to render a field with invalid type: {item_type}</p>;
              }

              }
            )}
          </div>
        </div>
      </React.Fragment>
    );
  }

  updateText (data_id, newValue) {
    let itemData = {...this.state.item_data};
    itemData[data_id].value = newValue
    this.setState({ item_data: itemData});
    sendTextValueUpdate(data_id, newValue);
  }

  updateValue (field, newValue) {
    let newValues = {...this.state.values};
    newValues[field] = newValue;
    this.setState({ values: newValues});
    // console.log("TODO: ajax. Field " + field + ", value " + newValue);
    // sendValueUpdate("/");
    sendValueUpdate(data_id, newValue);
  }
}

// HelloWorld.propTypes = {
//   greeting: PropTypes.string
// };
export default Profile;


function sendTextValueUpdate (data_id, value) {
  // Default options are marked with *
  // TODO(sdspikes): update route and options
    return fetch("/text_profile_item", {
        method: "PUT", // *GET, POST, PUT, DELETE, etc.
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({profile_item_data_id: data_id, value: value}), // body data type must match "Content-Type" header
    }) // .then((response) => {console.log(response.json())});
}


function sendValueUpdateOld (field, value) {
  // Default options are marked with *
    return fetch("/api/profiles/update_item", {
        method: "PUT", // *GET, POST, PUT, DELETE, etc.
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({field: field, value: value}), // body data type must match "Content-Type" header
    }) // .then((response) => {console.log(response.json())});
}


class Bio extends React.Component {
  constructor (props) {
    super(props);
    this.state = {
      currentlyEditing: false,
      currentContents: props.value
    };
  }

  render () {
    return <div>
      <h4>About me</h4>

      {this.state.currentlyEditing ?
        <div>
          <textarea value={this.state.currentContents} onChange={(e) => this.setState({currentContents: e.target.value})} />
          <div><button onClick={() => {
            this.props.onChange(this.state.currentContents);
            this.setState({currentlyEditing: false});
          }}>
            update bio
          </button></div>
        </div> :
        <div>
          {this.props.editing &&
              <button onClick={() => {this.setState({currentlyEditing: true})}}>Edit</button>}
          <p>{this.props.value || "No bio yet"}</p>
        </div>
      }

    </div>
  }

}
