connection: "bq_faa"

# --- CORE INCLUDES ---
include: "*.view"
include: "*.dashboard"

# ==========================================================
# || CORE EXPLORES (The "Hub" - Untouched by Spoke Teams) ||
# ==========================================================

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: products {}

explore: users {}

### CORE ORDER_ITEMS EXPLORE (The Hub) - NO CHANGES HERE ###
explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  # *** ADD SPOKE VIEW AS A JOIN ***
  join: cross_view_filtered_measures {
    view_label: "Order Items - Cross View Metrics"  # Group spoke fields separately
    type: left_outer
    sql_on: ${order_items.id} = ${cross_view_filtered_measures.id} ;;
    relationship: one_to_one
  }
}

# ================================================================
# || SPOKE EXPLORES (Your Team's Extension) ||
# ================================================================

### SPOKE ORDER_ITEMS EXPLORE (The Spoke) - CORRECTED IMPLEMENTATION ###
explore: order_items_spoke_metrics {
  hidden: yes
  # Use view_name to swap in the spoke view as the base
  view_name: cross_view_filtered_measures

  # Define all joins with 'from:' parameter to maintain relationships
  join: inventory_items {
    type: left_outer
    sql_on: ${cross_view_filtered_measures.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${cross_view_filtered_measures.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}
