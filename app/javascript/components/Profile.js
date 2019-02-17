import React from "react"
import PropTypes from "prop-types"


// const fields = {

// }

const fields = [
    { type: "option",
      name: "gender",
      displayName: "Gender",
      options: [
        { name: "male" },
        { name: "female" },
        { name: "nonbinary" },
      ]
    },
    { type: "option",
      name: "relationship_style",
      displayName: "Relationship style",
      options: [
        { name: "solo poly" },
        { name: "hierarchical poly" },
        { name: "mono" },
      ]
    },
    { type: "option",
      name: "current_relationships",
      displayName: "Current relationships",
      options: [
        {name :"primary"},
        {name :"primary and secondaries"},
        {name :"multiple non-hierarchical"},
        {name :"seeking primary"}
      ]
    }
  ]

class Profile extends React.Component {
  constructor (props) {
    super(props);
    this.state = {
      values: props.profile.values
    };
  }

  render () {
    const privacyGroups = ["all", "friends"];

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
            {fields.map((field, idx) => {
              const {type, name, displayName, options} = field;

              if (type == "option") {
                return <div className="box" key={idx}>
                    <span>{displayName || name}:&nbsp;</span>
                    {this.props.editing ?
                      <select
                        value={this.state.values[name] || ""}
                        onChange={(e) => this.updateValue(name, e.target.value)}>
                        <option value=""/>
                        {options.map((option, idx) =>
                            <option key={idx} value={option.name}>{option.name}</option>
                          )
                        }
                      </select> :
                    <span>{this.state.values[name] || "??"}</span>}
                  </div>;
              } else {
                return <p>Error: you tried to render a field with invalid type: {type}</p>;
              }

              }
            )}
          </div>
        </div>
      </React.Fragment>
    );
  }

  updateValue (field, newValue) {
    let newValues = {...this.state.values};
    newValues[field] = newValue;
    this.setState({ values: newValues});
    // console.log("TODO: ajax. Field " + field + ", value " + newValue);
    // sendValueUpdate("/");
    sendValueUpdate(field, newValue);
  }
}

// HelloWorld.propTypes = {
//   greeting: PropTypes.string
// };
export default Profile;



function sendValueUpdate (field, value) {
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
