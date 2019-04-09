import React from "react"
import PropTypes from "prop-types"

const category_type_to_item_type = {
  'text' : 'TextProfileItem',
  'multi' : 'ProfileItemResponse'
}

class NewProfileItem extends React.Component {
  constructor (props) {
    super(props);

    let categories = props.categories;
    this.state = {
      categories: categories,
      selected_category_id: Object.keys(categories).filter(id => !categories[id].used)[0],
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
          {Object.keys(categories).filter(id=>!categories[id].used).map((id) =>
              <option key={id} id={id} value={id}>{categories[id].title}</option>
          )}
        </select>
        <button onClick={(e) => this.createNewItem()}>
          Create new profile item
        </button>
      </span>
    }

    const {new_item, options} = this.state

    const { item_type, title, data } = categories[selected_category_id]

    return <div className="box">
      <span>{title}:&nbsp;</span>
        {item_type == "multi" && <select
            value={new_item.profile_item_data_id}
            onChange={(e) => this.updateValue(e.target, item_type)}>
            {options.map((option) =>
                <option key={option.id} id={option.id} value={option.id}>{option.value}</option>
              )
            }
          </select>
        }
        {item_type == "text" && <span>
          <input
            value={new_item.value || ""}
            onChange={(e) => this.updateText(e.target.value)}/>
          <button onClick={(e) => this.createTextItem(item_type)}>
            Set Value
          </button>
          </span>
        }
    </div>;
  }

  resetState () {
    const {categories, selected_category_id} = this.state
    categories[selected_category_id].used = true
    this.setState({
      selected_category_id: Object.keys(categories).filter(id => !categories[id].used)[0],
      editing: false,
      new_item: null,
      options: [],
    })
  } 

  createTextItem (item_type) {
    const {new_item, categories, selected_category_id} = this.state
    createTextItem(new_item.value, (json_response) => {
      new_item.profile_item_data_id = json_response.id
      new_item.profile_item_data_type = category_type_to_item_type[item_type]

      this.resetState()

      newProfileItem(new_item, (newItem) =>
        this.props.callback(newItem, json_response))
    })
  }

  updateValue (target, item_type) {
    var index = target.selectedIndex;
    var optionElement = target.childNodes[index]
    var option_id =  Number.parseInt(optionElement.getAttribute('id'));

    const {new_item, options, categories, selected_category_id} = this.state
    new_item.profile_item_data_id = option_id
    new_item.profile_item_data_type = category_type_to_item_type[item_type]

    this.resetState()

    newProfileItem(new_item, (newItem) =>
        this.props.callback(newItem, options.find(o => o.id === option_id), options))
  }

  updateText (newValue) {
    const {new_item} = this.state
    new_item.value = newValue
    this.setState({new_item: new_item})
  }

  updateCategoryId (id) {
    this.setState({selected_category_id: id})
  }

  createNewItem () {
    const {selected_category_id, categories} = this.state

    const options = (categories[selected_category_id] && categories[selected_category_id].options) || []

    this.setState({
      new_item: {
        profile_item_category_id: selected_category_id
      },
      editing: true,
      options
    })

    // profile_items.push({profile_item_category_id: selected_category_id})
  }
}
function createTextItem (value, callback) {
  return fetch("/api/profiles/text_profile_item", {
      method: "POST", // *GET, POST, PUT, DELETE, etc.
      headers: {
          "Content-Type": "application/json",
      },
      body: JSON.stringify({value: value, profile_item_data_attributes: {value: value }})
  })
  .then((response) => { return response.json() })
  .then((json_response) => callback(json_response));
}

function newProfileItem (new_profile_item, callback) {
  return fetch("/profile_items", {
      method: "POST", // *GET, POST, PUT, DELETE, etc.
      headers: {
          "Content-Type": "application/json",
      },
      body: JSON.stringify(new_profile_item)
  })
  .then((response) => { return response.json()})
  .then((json_response) => {
    if (callback) callback(json_response)
  })
}
export default NewProfileItem;
